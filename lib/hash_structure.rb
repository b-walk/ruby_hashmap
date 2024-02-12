# frozen_string_literal: true

class HashStructure
  attr_reader :buckets, :load_factor

  def initialize(load_factor = 0.75)
    @buckets = Array.new(16) { [] }
    @load_factor = load_factor
  end

  def clear
    buckets.map(&:clear)
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
end
