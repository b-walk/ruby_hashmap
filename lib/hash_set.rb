# frozen_string_literal: true

require_relative 'hash_structure'

class HashSet < HashStructure
  def set(key)
    bucket_at(key) << key
  end
end
