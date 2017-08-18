module SessionHelpers
  def sign_in
    user = create :user, password_to_be_hashed: '111111'
    sign_in_with user.email, '111111'
  end

  def admin_sign_in
    user = create :user, password_to_be_hashed: '111111', rank: 1
    sign_in_with user.email, '111111'
  end

  def sign_in_with(email, password)
    visit '/users/login'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button I18n.t('login_button')
  end

  def sign_up_with(email, name, password, secret_answer)
    visit '/users/register'

    fill_in 'email', with: email
    fill_in 'name', with: name
    fill_in 'password', with: password
    fill_in 'confirm_password', with: password
    fill_in 'secret_answer', with: secret_answer

    click_button I18n.t('register')
  end

  def restore_password_with(email, secret_answer, new_password)
    visit '/users/forgotten_password'

    fill_in 'email', with: email
    fill_in 'secret_answer', with: secret_answer
    fill_in 'new_password', with: new_password

    click_button I18n.t('restore_password')
  end
end

RSpec.configure do |config|
  config.include SessionHelpers
end
