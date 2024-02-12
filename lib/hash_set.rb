# frozen_string_literal: true

require_relative 'hash_structure'

class HashSet < HashStructure
  def set(key)
    bucket_at(key) << key
  end

  def has(key)
    bucket_at(key).include?(key)
  end

  def remove(key)
    bucket_at(key).delete(key)
  end

  def keys
    buckets.reduce([]) do |key_array, bucket|
      bucket.reduce(key_array) {|_key_array, key| _key_array << key}
    end
  end
end
