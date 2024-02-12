# frozen_string_literal: true

require_relative 'hash_structure'

class HashSet < HashStructure
  def set(key)
    bucket_at(key) << key
  end

  def has(key)
    buckets.any? do |bucket|
      bucket.include?(key)
    end
  end
end
