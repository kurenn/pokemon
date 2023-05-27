module PokeApi
  module Exception
    class APIError < StandardError
      attr_accessor :http_status, :response_body

      def initialize(http_status, response_body, _error_info = nil)
        @http_status = http_status
        super(response_body)
      end
    end

    # Any error with a 5xx HTTP status code
    class ServerError < APIError; end

    # Any error with a 4xx HTTP status code
    class ClientError < APIError; end
  end
end
