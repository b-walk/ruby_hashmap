# frozen_string_literal: true

class HashMap
  attr_reader :buckets

  def initialize(size = 16, load_factor = 0.75)
    @buckets = Array.new(size) { [] }
    @load_factor = load_factor
  end

  def hash(string)
    hash_code = 0
    string.each_char {|char| hash_code = hash_code * 31 + char.ord}
    hash_code % buckets.size
  end
end
