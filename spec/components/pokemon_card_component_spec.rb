# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokemonCardComponent, type: :component do
  let(:pokemon_file) { File.read('spec/json_responses/spearow.json') }
  let(:pokemon) { PokeApi::Pokemon.new(JSON.parse(pokemon_file, symbolize_names: true)) }

  it 'displays the pokemon number and name capitalized' do
    render_inline(described_class.new(pokemon))

    expect(page).to have_css('h3', text: '#21 Spearow')
  end

  it 'displays the pokemon height and weight' do
    render_inline(described_class.new(pokemon))

    expect(page).to have_content('Height: 30cm')
    expect(page).to have_content('Weight: 2kg')
  end

  it 'displays a link to view the pokemon' do
    render_inline(described_class.new(pokemon))

    expect(page).to have_css('a', text: 'View Pokemon')
  end

  it 'displays a link to mark the pokemon as favorite' do
    render_inline(described_class.new(pokemon))

    expect(page).to have_css('a', text: 'Favorite')
  end
end
