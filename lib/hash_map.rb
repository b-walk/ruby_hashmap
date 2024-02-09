# frozen_string_literal: true

class HashMap
  attr_reader :buckets, :load_factor

  def initialize(load_factor = 0.75)
    @buckets = Array.new(16) { [] }
    @load_factor = load_factor
  end

  Node = Struct.new(:key, :value)

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

  def length
    counter = 0
    full_buckets.each do |bucket|
      counter += bucket.length
    end
    counter
  end

  def print_details
    [
      "BUCKETS -> #{buckets}",
      "BUCKETS / CAPACITY -> #{full_buckets.size} / #{capacity}",
      "FULL_BUCKETS -> #{full_buckets}",
      "LENGTH -> #{length}"
    ].each {|detail| puts detail, "\n"}
  end

  private

  attr_writer :buckets

  def matching_node(key)
    bucket_at(key).find {|node| node.key == key}
  end

  def capacity
    buckets.size
  end

  def hash(string)
    hash_code = 0
    string.each_char {|char| hash_code = hash_code * 31 + char.ord}
    hash_code % capacity
  end

  def bucket_at(key)
    i = hash(key)
    raise IndexError if i.negative? || i >= capacity

    buckets[i]
  end

  def full_buckets
    buckets.reject {|bucket| bucket.empty?}
  end

  def max_buckets?
    full_buckets.size >= load_factor * capacity
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
