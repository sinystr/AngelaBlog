require 'spec_helper'

RSpec.describe 'Admin system', type: :feature do
  before { admin_sign_in }

  scenario 'allows admins to control users' do
    expect(page).to have_content I18n.t('users')
  end

  scenario 'allows admins to create articles' do
    expect(page).to have_content I18n.t('create_article')
  end

  scenario 'allows admins to control articles' do
    create :article
    visit '/articles'
    expect(page).to have_content I18n.t('change')
    expect(page).to have_content I18n.t('delete')
  end

  scenario 'allows admins to delete users' do
    user = create :user, email: 'delete_user@test.com', name: 'delete user'
    visit '/admin/users'
    click_on I18n.t('delete')
    expect(page).to_not have_content user.name
  end

  scenario 'allows admins see inactive articles' do
    article = create :article, active: 0
    visit '/articles'
    expect(page).to have_content article.title
  end

  scenario 'allows admins to delete comments' do
    article = create :article
    visit "/articles/#{article.id}"

    fill_in 'comment', with: 'TEST COMMENT'
    click_on I18n.t('add_comment')
    expect(page).to have_content 'TEST COMMENT'

    click_on I18n.t('delete')
    expect(page).to_not have_content 'TEST COMMENT'
  end

  scenario 'allows admins to change comments' do
    article = create :article
    visit "/articles/#{article.id}"
    
    fill_in 'comment', with: 'TEST COMMENT'
    click_on I18n.t('add_comment')
    expect(page).to have_content 'TEST COMMENT'

    click_on I18n.t('change')
    fill_in 'text', with: 'CHANGED COMMENT'
    click_on I18n.t('change_comment')

    expect(page).to have_content 'CHANGED COMMENT'
  end

  scenario 'allows admins to create articles' do
    visit '/admin/articles/create'
    attach_file('picture', 'spec/resources/testing_image.jpg')
    fill_in 'title_bg', with: 'BG TITLE'
    fill_in 'title_en', with: 'EN TITLE'
    fill_in 'text_bg', with: 'BG TEXT'
    fill_in 'text_en', with: 'EN TEXT'
    click_on I18n.t('publish')
    expect(page).to have_content 'BG TITLE'
  end

  scenario 'allows admins to change articles' do
    article = create :article
    visit "/admin/articles/edit/#{article.id}"
    fill_in 'title_bg', with: 'BG TITLE CHANGE'
    click_on I18n.t('update')
    expect(page).to have_content 'BG TITLE CHANGE'
  end
end
