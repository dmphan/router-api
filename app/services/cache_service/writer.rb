module CacheService
  class Writer < ApplicationService
    def initialize(key, value)
      @key = key
      @value = value
    end

    def call
      Rails.cache.write(@key, @value)
    end
  end
end