module PokeApi
  class PokemonCollection
    def initialize(data = {})
      @data = data
      @count = data[:count]
      @next = data[:next]
      @previous = data[:previous]
      @results = data[:results]
    end

    def fetch
      @fetch ||= @results.map do |result|
        PokeApi::Pokemon.find(result[:name])
      end
    end
  end
end
