require 'system_helper'

RSpec.describe 'Sessions', type: :system do
  let(:spearow_json) { File.read('spec/json_responses/spearow.json') }
  let(:bulbasaur_json) { File.read('spec/json_responses/bulbasaur.json') }
  let(:spearow) { PokeApi::Pokemon.new(JSON.parse(spearow_json, symbolize_names: true)) }
  let(:bulbasaur) { PokeApi::Pokemon.new(JSON.parse(bulbasaur_json, symbolize_names: true)) }

  context 'Log in' do
    let(:trainer) { create(:trainer) }

    scenario 'Signing in with an email' do
      allow(PokeApi::Pokemon).to receive(:all).and_return([spearow, bulbasaur])
      visit new_trainer_session_path

      expect(page).to have_content('Sign in to your account')
      fill_in 'Email', with: trainer.email
      fill_in 'Password', with: 'pikachu'
      click_on 'Sign in'

      expect(page).to have_content('Signed in successfully.')
    end
  end

  context 'Log out' do
    context 'when the user is a member' do
      let(:trainer) { create(:trainer) }

      before do
        sign_in trainer
      end

      scenario 'Login out from the platform' do
        allow(PokeApi::Pokemon).to receive(:all).and_return([spearow, bulbasaur])
        visit root_path
        click_on 'Log out'

        expect(page).to have_content('Sign in to your account')
      end
    end
  end
end
