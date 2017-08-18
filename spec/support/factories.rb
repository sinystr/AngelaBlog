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
end
