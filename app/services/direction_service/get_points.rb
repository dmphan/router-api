module DirectionService
  class GetPoints < ApplicationService

    def initialize(from, to)
      @from = from
      @to = to
    end

    def call
      call_api
      transform_response
    end

    private

    def call_api
      @response = DirectionsClient.new.get_directions(from: @from, to: @to)
    end

    def transform_response
      { 
        points: ::FastPolylines.decode(@response.dig("paths", 0, "points")),
        distance: @response.dig("paths", 0, "distance")
      }
    end
  end
end