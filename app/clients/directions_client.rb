class DirectionsClient
  include HttpClient
  include Errors

  http_config 'https://directions.ridewithgps.com'.freeze

  def get_directions(from:, to:)
    @response = client.get do |req|
                req.url 'route'
                req.options.params_encoder = Faraday::FlatParamsEncoder
                req.params = {
                  point: [from, to],
                  profile: 'car',
                  elevation: false,
                  points_encoded: true
                }
              end

    parsed_response = Oj.load(@response.body)

    return parsed_response if response_successful?

    raise error_class(@response.status, parsed_response.dig('message'))
  end
end
