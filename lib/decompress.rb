require 'json'
require 'set'

def decompress_rec(obj, dictionary, path)
    if obj.is_a?(Hash)
        obj.each do |key, value|
            path.push(key)
            obj[key] = decompress_rec(value, dictionary, path)
            path.pop
        end
        obj
    elsif obj.is_a?(Array)
        obj.map{ |item| decompress_rec(item, dictionary, path) }
    elsif obj.is_a?(Numeric) && dictionary["fields"].member?(path)
        dictionary["strings"][obj]
    else
        obj
    end
end

def decompress(obj)
    dictionary = obj.delete("dictionary")
    dictionary["fields"] = Set.new(dictionary["fields"].map{ |field| field.split('.') })
    obj['events'] = decompress_rec(obj['events'], dictionary, [])
    obj
end

puts decompress(JSON.parse(ARGF.read)).to_json