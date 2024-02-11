# frozen_string_literal: true

class Node
  attr_accessor :value
  attr_reader :key

  def initialize(key, value)
    @key = key
    @value = value
  end

  def pair
    [key, value]
  end
end
