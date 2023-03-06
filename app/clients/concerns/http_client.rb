module HttpClient
  extend ActiveSupport::Concern

  included do
    class_attribute :base_uri

    def client
      @_client ||= Faraday.new(base_uri) do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
      end
    end

    def response_successful?
      @response.status == 200
    end
  end

  class_methods do
    def http_config(base_uri)
      self.base_uri = base_uri
    end
  end
end
