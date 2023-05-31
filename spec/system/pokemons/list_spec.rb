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

    scenario 'lists all pokemons' do
      allow(PokeApi::Pokemon).to receive(:all).and_return([spearow, bulbasaur])

      visit pokemons_path

      within('#pokemon-1') do
        expect(page).to have_css('h3', text: '#1 Bulbasaur')
        expect(page).to have_content('Height: 70cm')
        expect(page).to have_content('Weight: 6kg')
        expect(page).to have_css('a', text: 'View Pokemon')
        expect(page).to have_css('button', text: 'Favorite')
      end

      within('#pokemon-21') do
        expect(page).to have_css('h3', text: '#21 Spearow')
        expect(page).to have_content('Height: 30cm')
        expect(page).to have_content('Weight: 2kg')
        expect(page).to have_css('a', text: 'View Pokemon')
        expect(page).to have_css('button', text: 'Favorite')
      end
    end

    scenario 'loads more pokemons' do
      allow(PokeApi::Pokemon).to receive(:all).with(offset: 0).and_return([bulbasaur])

      visit pokemons_path

      within('#pokemon-1') do
        expect(page).to have_css('h3', text: '#1 Bulbasaur')
        expect(page).to have_content('Height: 70cm')
        expect(page).to have_content('Weight: 6kg')
        expect(page).to have_css('a', text: 'View Pokemon')
        expect(page).to have_css('button', text: 'Favorite')
      end

      allow(PokeApi::Pokemon).to receive(:all).with(offset: '20').and_return([spearow])
      click_button 'Load more'

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
