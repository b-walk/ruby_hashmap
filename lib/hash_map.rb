# frozen_string_literal: true

class HashMap
  attr_reader :buckets, :load_factor

  def initialize(size = 16, load_factor = 0.75)
    @buckets = Array.new(size) { [] }
    @load_factor = load_factor
  end

  def set(key, value)
    bucket = bucket_at(key)
    node = [key, value]

    match = bucket.assoc(key)
    if match
      match.replace(node)
    else
      bucket << node
    end

    # TODO: add method that grows and rehashes buckets once a threshold is reached
  end

  def capacity
    buckets.size
  end

  private

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
end
