require 'rails_helper'

RSpec.describe PokeApi::Pokemon::Moves do
  let(:moves_attributes) do
    [
      {
        move: {
          name: 'razor-wind',
          url: 'https://pokeapi.co/api/v2/move/13/'
        }
      },
      {
        move: {
          name: 'swords-dance',
          url: 'https://pokeapi.co/api/v2/move/14/'
        }
      }
    ]
  end

  it 'is expected to behave like an Array' do
    moves = described_class.new(moves_attributes)

    expect(moves).to be_a(Array)
    expect(moves[0]).to be_a(PokeApi::Pokemon::Move)
  end
end
