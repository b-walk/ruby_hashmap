# frozen_string_literal: true

require_relative 'hash_structure'

class HashMap < HashStructure
  attr_reader :buckets, :load_factor

  def initialize(load_factor = 0.75)
    @buckets = Array.new(16) { [] }
    @load_factor = load_factor
  end

  def set(key, value)
    if matching_node(key)
      match.value = value
    else
      bucket_at(key) << Node.new(key, value)
    end

    grow_and_rehash if max_buckets?
  end

  def get(key)
    node = matching_node(key)
    node.value if node
  end

  def has(key)
    !matching_node(key).nil?
  end

  def remove(key)
    node = matching_node(key)
    value = node ? node.value : nil

    bucket_at(key).delete_if {|node| node.key == key}
    
    value
  end

  def keys
    buckets.reduce([]) do |key_array, bucket|
      bucket.reduce(key_array) {|_key_array, node| _key_array << node.key}
    end
  end

  def values
    buckets.reduce([]) do |key_array, bucket|
      bucket.reduce(key_array) {|_key_array, node| _key_array << node.value}
    end
  end

  def entries
    pairs = []
    nodes.each {|node| pairs << node.pair}
    pairs
  end

  def print_details
    [
      "BUCKETS -> #{buckets}",
      "BUCKETS / CAPACITY -> #{full_buckets.size} / #{capacity}",
      "FULL_BUCKETS -> #{full_buckets}",
      "LENGTH -> #{length}",
      "KEYS -> #{keys}",
      "VALUES -> #{values}",
      "ENTRIES -> #{entries}"
    ].each {|detail| puts detail, "\n"}
  end

  private

  attr_writer :buckets

  def nodes
    node_array = []
    buckets.each do |bucket|
      next if bucket.empty?
      bucket.each {|node| node_array << node}
    end
    node_array
  end

  def matching_node(key)
    bucket_at(key).find {|node| node.key == key}
  end

  def grow_and_rehash
    saved_nodes = []
    full_buckets.each do |bucket|
      bucket.each {|node| saved_nodes << node}
    end

    @buckets = Array.new(capacity * 2) { [] }
    saved_nodes.each {|node| set(node.key, node.value)}
  end
end
