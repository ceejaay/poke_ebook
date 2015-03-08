require 'json'
require 'open-uri'
def remove_its(string)
  string.gsub! /\bit\b/i, "you"
  string.gsub! /\bits\b/i, "your"
  return string
end

=begin
10.times do 
  number = 3
  puts number += 1
  puts JSON.parse(open("http://pokeapi.co/api/v1/description/#{number}/").read)["description"].gsub! "its", "your"

end
=end
10.times do
  y = JSON.parse(open("http://pokeapi.co/api/v1/description/#{rand(999) + 1}/").read)["description"]
  remove_its(y)
  puts y

end
