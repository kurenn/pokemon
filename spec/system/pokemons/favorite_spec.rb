require 'system_helper'

RSpec.describe 'Pokemons List', type: :system do
  let(:spearow_json) { File.read('spec/json_responses/spearow.json') }
  let(:bulbasaur_json) { File.read('spec/json_responses/bulbasaur.json') }
  let(:spearow) { PokeApi::Pokemon.new(JSON.parse(spearow_json, symbolize_names: true)) }
  let(:bulbasaur) { PokeApi::Pokemon.new(JSON.parse(bulbasaur_json, symbolize_names: true)) }

  context 'when the user is signed in' do
    let(:trainer) { create(:trainer, email: 'ash@local.com') }

    before do
      sign_in trainer
    end

    scenario 'favorited bulbasaur' do
      allow(PokeApi::Pokemon).to receive(:all).and_return([bulbasaur])

      visit pokemons_path

      within('#pokemon-1') do
        click_button 'Favorite'
        expect(page).to have_css('button svg.text-yellow-400', count: 1)
      end
    end

    scenario 'unfavorited bulbasaur' do
      allow(PokeApi::Pokemon).to receive(:all).and_return([bulbasaur])
      create(:favorite, trainer:, pokemon_id: 1)

      visit pokemons_path

      within('#pokemon-1') do
        click_button 'Favorite'
        expect(page).to have_css('button svg.text-gray-400', count: 1)
      end
    end
  end
end
