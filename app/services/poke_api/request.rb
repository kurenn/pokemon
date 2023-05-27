module PokeApi
  class Request
    include HTTParty
    base_uri 'https://pokeapi.co/api/v2'

    def initialize(response)
      @response = response
    end

    def self.get(uri_path, params = {})
      response = super(uri_path, params)

      return new(response) if response.success?

      raise PokeApi::Exception::ServerError.new(response.code, response.body) if response.code >= 500
      raise PokeApi::Exception::ClientError.new(response.code, response.body) if response.code < 500
    end

    def serialize
      JSON.parse(@response.body, symbolize_names: true)
    end

    def body
      @response.body
    end
  end
end
