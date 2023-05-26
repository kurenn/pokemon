require 'rails_helper'

RSpec.describe PokeApi::Pokemon::Abilities do
  let(:abilities_attributes) do
    [
      {
        ability: {
          name: 'overgrow',
          url: 'https://pokeapi.co/api/v2/ability/65/'
        },
        is_hidden: false,
        slot: 1
      },
      {
        ability: {
          name: 'chlorophyll',
          url: 'https://pokeapi.co/api/v2/ability/34/'
        },
        is_hidden: true,
        slot: 3
      }
    ]
  end

  it 'is expected to behave like an Array' do
    abilities = described_class.new(abilities_attributes)

    expect(abilities).to be_a(Array)
    expect(abilities[0]).to be_a(PokeApi::Pokemon::Ability)
  end
end
