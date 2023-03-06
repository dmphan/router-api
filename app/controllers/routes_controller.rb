class RoutesController < ApplicationController
  before_action :validate_param_presence
  before_action :validate_param_format

  def index
      from = params[:from]
      to = params[:to]
      
      cache_key = CacheService::KeyGenerator.call(
          from.split(',').map(&:to_f),
          to.split(',').map(&:to_f)
      )

      response = CacheService::Reader.call(cache_key)

      if response.nil?
        coords = DirectionService::GetPoints.call(from, to)
        elevations = ElevationService::GetElevation.call(coords&.dig(:points))
        points = coords[:points].map.with_index do |c, i|
            c << elevations[i]
        end

        response = { 
          total_distance: coords[:distance],
          points: points
        }
        CacheService::Writer.call(cache_key, response)
      end

      render json: response
  end

  private

  def validate_param_presence
    unless params[:from].present? && params[:to].present?
      render json: { message: 'Missing required params' }, status: :bad_request
    end
  end

  def validate_param_format
    coord_regex = /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/
    unless coord_regex.match?(params[:from]) && coord_regex.match?(params[:to])
      render json: { message: 'Unable to parse query params'}, status: :bad_request
    end
  end
end
