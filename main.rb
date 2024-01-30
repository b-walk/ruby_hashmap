# frozen_string_literal: true

require_relative 'lib/hash_map'

hash_map = HashMap.new
puts "Buckets -> #{hash_map.buckets}"

hash_map.set('blake walker', '22')
hash_map.set('blaek wakler', '22')
hash_map.set('sky', 'blue')

puts "Capacity -> #{hash_map.capacity}"
