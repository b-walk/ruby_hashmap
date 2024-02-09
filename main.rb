# frozen_string_literal: true

require 'pry-byebug'

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
hash_map.set('movie posters', 'multi')
hash_map.set('mannequin head', 'brown')
hash_map.set('Rubik\'s Cube', 'multi')
hash_map.set('computer case', 'black')
hash_map.set('iPhone', 'black')
hash_map.set('record player', 'white')
hash_map.set('crocs', 'multi')
hash_map.set('coat', 'multi')
hash_map.set('toothbrush', 'multi')
hash_map.set('t-shirt', 'black')
hash_map.set('LEGOS', 'multi')
hash_map.set('hydroflask', 'green')
hash_map.set('Amulet of Kings', 'red')
hash_map.set('ruby', 'red')

hash_map.print_details

puts hash_map.get('toothbrush') # => multi
puts hash_map.get('jungle') # => nil

puts hash_map.has('LEGOS') # => true
puts hash_map.has('mannequin head') # => true
puts hash_map.has('dessert') # => false
