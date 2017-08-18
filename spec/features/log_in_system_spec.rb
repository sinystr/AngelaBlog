require 'spec_helper'

RSpec.describe 'Login system', type: :feature do
  scenario 'User log in with correct credentials' do
    sign_in
    expect(page).to have_content I18n.t('logout')
  end

  scenario 'User tries to login with incorrect credentials' do
    visit '/users/login'
    create :user, email: 'test@test.com', password_to_be_hashed: '111111'

    within '#login-form' do
      fill_in 'email', with: 'test@test.com'
      fill_in 'password', with: 'incorrectpassword'
    end

    click_button I18n.t('login_button')

    expect(page).to_not have_content I18n.t('logout')
  end

  scenario 'User restores password' do
    visit '/users/forgotten_password'
    create :user, email: 'test@test.com', secret_answer: 'Pirates of the Carribean'

    within '#forgot_password' do
      fill_in 'email', with: 'test@test.com'
      fill_in 'secret_answer', with: 'Pirates of the Carribean'
      fill_in 'new_password', with: 'newpassword'
    end

    click_button I18n.t('restore_password')

    expect(page).to have_content I18n.t('restore_password_success')
  end

  scenario 'User restores password with incorrect secret answer' do
    visit '/users/forgotten_password'
    create :user, email: 'test@test.com', secret_answer: 'Pirates of the Carribean'

    within '#forgot_password' do
      fill_in 'email', with: 'test@test.com'
      fill_in 'secret_answer', with: 'Inception'
      fill_in 'new_password', with: 'newpassword'
    end

    click_button I18n.t('restore_password')

    expect(page).to have_content I18n.t('wrong_secret_answer')
  end

  scenario 'User restores password with email that does not exist' do
    visit '/users/forgotten_password'

    within '#forgot_password' do
      fill_in 'email', with: 'test@test.com'
      fill_in 'secret_answer', with: 'Inception'
      fill_in 'new_password', with: 'newpassword'
    end

    click_button I18n.t('restore_password')

    expect(page).to have_content I18n.t('user_does_not_exist')
  end

  scenario 'User registers with correct credentials' do
    visit '/users/register'

    within '#register-form' do
      fill_in 'email', with: 'test@test.com'
      fill_in 'name', with: 'Georgi Georgiev'
      fill_in 'password', with: '111111'
      fill_in 'confirm_password', with: '111111'
      fill_in 'secret_answer', with: 'Pirates of the Carribean'
    end

    click_button I18n.t('register')

    expect(page).to have_content I18n.t('register_success')
  end

  scenario 'User registers with invalid email' do
    visit '/users/register'

    within '#register-form' do
      fill_in 'email', with: 'testtest'
      fill_in 'name', with: 'Georgi Georgiev'
      fill_in 'password', with: '111111'
      fill_in 'confirm_password', with: '111111'
      fill_in 'secret_answer', with: 'Pirates of the Carribean'
    end

    click_button I18n.t('register')

    expect(page).to have_content 'Въведения текст в полето за и-мейл е невалиден'
  end

  scenario 'User registers with already existing email' do
    visit '/users/register'

    create :user, email: 'test@test.com'

    within '#register-form' do
      fill_in 'email', with: 'test@test.com'
      fill_in 'name', with: 'Georgi Georgiev'
      fill_in 'password', with: '111111'
      fill_in 'confirm_password', with: '111111'
      fill_in 'secret_answer', with: 'Pirates of the Carribean'
    end

    click_button I18n.t('register')

    expect(page).to have_content 'Използвали сте и-мейл който вече e зает от друг потребител.'
  end

  scenario 'User registers with invalid name' do
    visit '/users/register'

    within '#register-form' do
      fill_in 'email', with: 'test@test.com'
      fill_in 'name', with: 'asd'
      fill_in 'password', with: '111111'
      fill_in 'confirm_password', with: '111111'
      fill_in 'secret_answer', with: 'Pirates of the Carribean'
    end

    click_button I18n.t('register')

    expect(page).to have_content 'Въведения текст в полето за име е прекалено кратък.'
  end

  # scenario 'User registers with invalid password' do
  #     visit '/users/register'

  #     within '#register-form' do
  #         fill_in 'email', with: 'test@test.com'
  #         fill_in 'name', with: 'Georgi Georgiev'
  #         fill_in 'password', with: '111'
  #         fill_in 'confirm_password', with: '111'
  #         fill_in 'secret_answer', with: 'Pirates of the Carribean'
  #     end

  #     click_button I18n.t('register')

  #     expect(page).to have_content 'Въведения текст в полето за парола е прекалено кратък.'
  # end

  scenario 'User logouts' do
    sign_in
    click_on I18n.t('logout')
    expect(page).to have_content I18n.t('login_button')
  end
end
