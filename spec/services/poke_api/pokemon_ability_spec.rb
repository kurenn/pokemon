require 'rails_helper'

RSpec.describe PokeApi::Pokemon::Ability do
  describe '#is_hidden?' do
    context 'when the ability is not hidden' do
      it 'returns false' do
        attributes = { is_hidden: false }

        ability = described_class.new(attributes)

        expect(ability).not_to be_hidden
      end
    end
    context 'when the ability is hidden' do
      it 'returns true' do
        attributes = { is_hidden: true }

        ability = described_class.new(attributes)

        expect(ability).to be_hidden
      end
    end
  end

  describe '#slot' do
    it 'returns the slot' do
      attributes = { slot: 1 }

      ability = described_class.new(attributes)

      expect(ability.slot).to eq(1)
    end
  end

  describe '#name' do
    it 'returns the name' do
      attributes = { ability: { name: 'overgrow' } }

      ability = described_class.new(attributes)

      expect(ability.name).to eq('overgrow')
    end
  end

  describe '#url' do
    it 'returns the url' do
      attributes = { ability: { url: 'https://pokeapi.co/api/v2/ability/65/' } }

      ability = described_class.new(attributes)

      expect(ability.url).to eq('https://pokeapi.co/api/v2/ability/65/')
    end
  end
end
