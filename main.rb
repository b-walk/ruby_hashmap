# frozen_string_literal: true

require_relative 'lib/hash_map'

hash_map = HashMap.new
puts "Buckets -> #{hash_map.buckets}"

hash_map.set('grass', 'green')
hash_map.set('shoes', 'white')
hash_map.set('sky', 'blue')

puts "Capacity -> #{hash_map.capacity}"
puts "Buckets -> #{hash_map.buckets}"
puts "Full Buckets -> #{hash_map.full_buckets}"
