# frozen_string_literal: true

class HashMap
  attr_reader :buckets, :load_factor

  def initialize(load_factor = 0.75)
    @buckets = Array.new(16) { [] }
    @load_factor = load_factor
  end

  Node = Struct.new(:key, :value)

  def set(key, value)
    bucket = bucket_at(key)

    match = bucket.find {|node| node.key == key}
    if match
      match.value = value
    else
      bucket << Node.new(key, value)
    end

    grow_and_rehash if max_buckets?
  end

  def get(key)
    bucket = bucket_at(key)

    match = bucket.find {|node| node.key == key}
    match.value if match
  end

  def print_details
    [
      "BUCKETS -> #{buckets}",
      "BUCKETS / CAPACITY -> #{full_buckets.size} / #{capacity}",
      "FULL_BUCKETS -> #{full_buckets}",
    ].each {|detail| puts detail, "\n"}
  end

  private

  attr_writer :buckets

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
