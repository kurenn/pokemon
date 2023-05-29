require 'system_helper'

RSpec.describe 'Sessions', type: :system do
  context 'Log in' do
    let(:trainer) { create(:trainer) }

    scenario 'Signing in with an email' do
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
        visit root_path
        click_on 'Sign out'

        expect(page).to have_content('Signed out successfully.')
      end
    end
  end
end
