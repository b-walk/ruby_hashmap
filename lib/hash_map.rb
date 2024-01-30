# frozen_string_literal: true

class HashMap
  attr_reader :buckets

  def initialize(size = 16, load_factor = 0.75)
    @buckets = Array.new(size) { [] }
    @load_factor = load_factor
  end
end
