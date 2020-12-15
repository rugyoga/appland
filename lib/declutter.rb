require 'json'

appland = JSON.parse(ARGF.read)
appland['events'].reject! { |event| /(set|get|is)/.match(event['method_id']) }

puts appland.to_json