class ElevationClient
  include HttpClient
  include Errors

  http_config 'https://gis.ridewithgps.com'.freeze

  def get_elevation(lats, longs)
    @response = client.post(
      'get_eles',
      {
        lats: lats.join(','),
        lngs: longs.join(',')
      }
    )

    parsed_response = Oj.load(@response.body)

    return parsed_response if response_successful?

    raise error_class(@response.status, parsed_response.dig('message'))
  end
end