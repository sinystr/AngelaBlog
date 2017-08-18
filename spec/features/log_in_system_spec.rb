require 'spec_helper'

RSpec.describe 'Login system', type: :feature do
  scenario 'allows users to log in with correct credentials' do
    sign_in
    expect(page).to have_content I18n.t('logout')
  end

  scenario 'does not allow users to log in with incorrect credentials' do
    sign_in_with 'incorrect@gmail.com', '111111'
    expect(page).to_not have_content I18n.t('logout')
  end

  scenario 'allows users to restore lost passwords' do
    user = create :user
    restore_password_with user.email, user.secret_answer, 'newpass'
    sign_in_with(user.email, 'newpass')
    expect(page).to have_content I18n.t('logout')
  end

  scenario 'does not allow user to restore lost password with incorrect secret answer' do
    user = create :user, secret_answer: 'Pirates of the Carribean'
    restore_password_with user.email, 'Inception', 'newpass'
    expect(page).to have_content I18n.t('wrong_secret_answer')
  end

  scenario 'does not allow user to restore lost password for email that does not exist' do
    restore_password_with 'notexisting@test.com', 'notexisting', 'notexisting'
    expect(page).to have_content I18n.t('user_does_not_exist')
  end

  scenario 'allows user to register correct credentials' do
    user = build(:user)
    sign_up_with(user.email, user.name, '111111', user.secret_answer)
    expect(page).to have_content I18n.t('register_success')
  end

  scenario 'does not allow user to register with invalid email' do
    user = build(:user)
    sign_up_with('testtest', user.name, '111111', user.secret_answer)
    expect(page).to have_content 'Въведения текст в полето за и-мейл е невалиден'
  end

  scenario 'does not allow user to register with already existing email' do
    user = create(:user)
    sign_up_with(user.email, user.name, '111111', user.secret_answer)
    expect(page).to have_content 'Използвали сте и-мейл който вече e зает от друг потребител.'
  end

  scenario 'does not allow user to register with invalid name' do
    user = build(:user)
    sign_up_with(user.email, 'srt', '111111', user.secret_answer)
    expect(page).to have_content 'Въведения текст в полето за име е прекалено кратък.'
  end

  scenario 'does not allow user to register with invalid password' do
    user = build(:user)
    sign_up_with(user.email, user.name, '111', user.secret_answer)
    expect(page).to have_content I18n.t('password_invalid')
  end

  scenario 'allows user to log out once logged in' do
    sign_in
    click_on I18n.t('logout')
    expect(page).to have_content I18n.t('login_button')
  end
end
