module SessionHelpers
  #   def sign_up_with(email, password)
  #     visit '/users/logion'
  #     fill_in 'email', with: email
  #     fill_in 'password', with: password
  #     click_button 'Sign up'
  #   end

  def sign_in
    user = create :user, password_to_be_hashed: '111111'
    visit '/users/login'
    fill_in 'email', with: user.email
    fill_in 'password', with: '111111'
    click_button I18n.t('login_button')
  end
end

RSpec.configure do |config|
  config.include SessionHelpers
end
