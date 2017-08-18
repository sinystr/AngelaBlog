require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    name 'Георги Георгиев'
    password_to_be_hashed '111111'
    rank 0
    secret_answer 'Pirates of the Carribean'
  end

  factory :tag do
    name 'EXAMPLE TAG'
  end

  factory :article do
    title_en 'English title'
    text_en 'English text'
    title_bg 'Bulgarian title'
    text_bg 'Bulgarian text'
    active true

    factory :article_with_tag do
      after(:create) do |article|
        article.tags << create(:tag)
      end
    end
  end
end
