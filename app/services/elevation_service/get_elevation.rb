module ElevationService
  class GetElevation < ApplicationService
    def initialize(points)
      @points = points
      @lats = []
      @longs = []
    end

    def call
      separate_lat_long
      call_api
    end

    private
    
    def separate_lat_long
      @points.each do |coord|
        @lats << coord.first
        @longs << coord.last
      end
    end

    def call_api
      ElevationClient.new.get_elevation(@lats, @longs)
    end
  end
end