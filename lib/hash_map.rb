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

    # TODO: add method that grows and rehashes buckets once a threshold is reached
  end

  def capacity
    buckets.size
  end

  # private

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

  def print_details
    [
      "BUCKETS -> #{buckets}",
      "CAPACITY -> #{capacity}",
      "FULL_BUCKETS -> #{full_buckets}",
      "MAX_BUCKETS? -> #{max_buckets?}"
    ].each {|detail| puts detail, "\n"}
  end
end
