require 'spec_helper'

RSpec.describe 'Articles system', type: :feature do
  scenario 'displays all articles' do
    article = create :article
    visit('/articles')
    expect(page).to have_content article.title
  end

  scenario 'Displays single article' do
    article = create :article
    visit("/articles/#{article.id}")
    expect(page).to have_content article.title
  end

  scenario 'does not allow unregistered users to comment' do
    open_article
    expect(page).to_not have_content I18n.t('add_comment')
  end

  scenario 'Allows registered users to comment' do
    sign_in
    open_article
    expect(page).to have_content I18n.t('add_comment')
  end

  scenario 'allows registered users to post comments' do
    sign_in
    open_article
    fill_in 'comment', with: 'Example comment.'
    click_button I18n.t('add_comment')
    expect(page).to have_content 'Example comment.'
  end

  scenario 'allows users to see all tags used in articles' do
    article = create :article_with_tag
    visit '/tags'
    expect(page).to have_content 'EXAMPLE TAG'
  end

  scenario 'allows users to see all articles for certain tag' do
    article = create :article_with_tag
    visit "articles/tag/#{article.tags[0].id}"
    expect(page).to have_content article.title
  end

  scenario 'does not allow unregistered users to see inactive articles' do
    article = create :article, active: 0
    visit '/articles'
    expect(page).to_not have_content article.title
  end

  scenario 'does not allow not privileged users to see inactive articles' do
    sign_in
    article = create :article, active: 0
    visit '/articles'
    expect(page).to_not have_content article.title
  end
end
