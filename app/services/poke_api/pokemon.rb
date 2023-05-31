module PokeApi
  class Pokemon
    attr_reader :id, :name, :height, :weight, :abilities, :moves

    # Map almost every attribute from the API to a local attribute
    def initialize(attributes)
      @id = attributes[:id]
      @name = attributes[:name]
      @height = attributes[:height]
      @weight = attributes[:weight]
      @types = attributes[:types]
      @abilities = Pokemon::Abilities.new(attributes[:abilities])
      @moves = Pokemon::Moves.new(attributes[:moves])
    end

    def types
      @types.map { |type| type[:type][:name] }
    end

    def self.search(pokemon_name = '')
      response = PokeApi::Request.get('/pokemon', limit: 1_281)

      pokemons = response.serialize[:results].select do |pokemon|
        pokemon[:name].include?(pokemon_name)
      end

      PokeApi::PokemonCollection.new({ results: pokemons }).fetch
    end

    def img_url
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/#{id}.png"
    end

    def self.all(offset: 0, limit: 20)
      response = PokeApi::Request.get('/pokemon/', offset:, limit:)

      PokeApi::PokemonCollection.new(response.serialize).fetch
    end

    def self.find(id)
      response = PokeApi::Request.get("/pokemon/#{id}")

      new(response.serialize)
    end

    class Ability
      def initialize(attributes = {})
        @attributes = attributes
      end

      def hidden?
        @attributes[:is_hidden]
      end

      def slot
        @slot ||= @attributes[:slot]
      end

      def name
        @name ||= @attributes[:ability][:name]
      end

      def url
        @url ||= @attributes[:ability][:url]
      end
    end

    class Abilities < Array
      def initialize(abilities = {})
        super(abilities.map { |ability| Pokemon::Ability.new(ability) })
      end
    end

    class Move
      def initialize(attributes = {})
        @attributes = attributes
      end

      def name
        @name ||= @attributes[:move][:name]
      end

      def url
        @url ||= @attributes[:move][:url]
      end
    end

    class Moves < Array
      def initialize(moves = {})
        super(moves.map { |move| Pokemon::Move.new(move) })
      end
    end
  end
end
