module ArticleHelpers
  def open_article
    article = create :article
    visit("/articles/#{article.id}")
  end
end

RSpec.configure do |config|
  config.include ArticleHelpers
end
