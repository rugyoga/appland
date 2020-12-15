require 'json'
require 'set'

def compress_rec(obj, dictionary, path)
    if obj.is_a?(Hash)
        obj.each do |key, value|
            path.push(key)
            new_value = compress_rec(value, dictionary, path)
            path.pop
            obj[key] = new_value
        end
        obj
    elsif obj.is_a?(Array)
        obj.map{ |item| compress_rec(item, dictionary, path) }
    elsif obj.is_a?(String)
        encoding = dictionary[:mapping][obj]
        if encoding.nil?
            dictionary[:fields].add(path.clone)
            encoding = dictionary[:strings].size
            dictionary[:mapping][obj] = encoding
            dictionary[:strings].push(obj)
        end
        encoding
    else
        obj
    end
end

def compress(obj)
    dictionary = { fields: Set.new, mapping: {}, strings: [] }
    compress_rec(obj['events'], dictionary, [])
    dictionary.delete(:mapping)
    dictionary[:fields] = dictionary[:fields].map{ |path| path.join('.') }
    obj[:dictionary] = dictionary
    obj
end

puts compress(JSON.parse(ARGF.read)).to_json