class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :text, presence: true
  validates :text, length: { minimum: 2, maximum: 120 }
end
