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

    scenario 'filters the pokemons list' do
      allow(PokeApi::Pokemon).to receive(:search).with('spear').and_return([spearow])
      allow(PokeApi::Pokemon).to receive(:all).and_return([spearow, bulbasaur])

      visit pokemons_path

      fill_in 'search', with: 'spear'
      find('#search').native.send_keys(:return)

      within('#pokemon-21') do
        expect(page).to have_css('h3', text: '#21 Spearow')
        expect(page).to have_content('Height: 30cm')
        expect(page).to have_content('Weight: 2kg')
        expect(page).to have_css('a', text: 'View Pokemon')
        expect(page).to have_css('button', text: 'Favorite')
      end
    end
  end
end
