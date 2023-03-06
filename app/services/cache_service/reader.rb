module CacheService
  class Reader < ApplicationService
    def initialize(key)
      @key = key
    end

    def call
      Rails.cache.fetch(@key)
    end
  end
end