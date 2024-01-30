# frozen_string_literal: true

require_relative 'lib/hash_map'

hash_map = HashMap.new
p hash_map.buckets

p hash_map.hash('blake walker')
p hash_map.hash('blaek wakler')
