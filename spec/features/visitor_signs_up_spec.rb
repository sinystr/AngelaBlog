require 'spec_helper'

RSpec.describe 'Login system', type: :feature do
  describe 'user login' do
    before { visit '/users/login' }

    it 'can login with correct credentials' do
      within 'form#login-form' do
        fill_in 'email', with: 'sinystr@gmail.com'
        fill_in 'password', with: '4$!Georgi'
      end

      click_on 'вход'

      expect(page).to have_content 'Изход'
    end
  end
end
