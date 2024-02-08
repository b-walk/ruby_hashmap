# frozen_string_literal: true

require_relative 'lib/hash_map'

hash_map = HashMap.new

hash_map.set('grass', 'green')
hash_map.set('shoes', 'white')
hash_map.set('sky', 'blue')
hash_map.set('clothes', 'purple')
hash_map.set('robes', 'purple')
hash_map.set('cartridge', 'orange')
hash_map.set('car', 'beige')
hash_map.set('eyes', 'blue')

hash_map.print_details
