require 'rails_helper'

RSpec.describe PokeApi::Pokemon::Move do
  describe '#name' do
    it 'returns the name' do
      attributes = { move: { name: 'razor-wind' } }

      move = described_class.new(attributes)

      expect(move.name).to eq('razor-wind')
    end
  end

  describe '#url' do
    it 'returns the url' do
      attributes = { move: { url: 'https://pokeapi.co/api/v2/move/13/' } }

      move = described_class.new(attributes)

      expect(move.url).to eq('https://pokeapi.co/api/v2/move/13/')
    end
  end
end
