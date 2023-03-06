module CacheService
  class KeyGenerator < ApplicationService
    H3_RESOLUTION = 12

    def initialize(from, to)
      @from = from
      @to = to
    end

    def call
      cell_f = ::H3.from_geo_coordinates(@from, H3_RESOLUTION)
      cell_t = ::H3.from_geo_coordinates(@to, H3_RESOLUTION)

      "#{cell_f}-#{cell_t}"
    end
  end
end