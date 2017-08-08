class User < ActiveRecord::Base
  validates :email, presence: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :name, length: {minimum: 6, maximum: 120}
  validates :password, presence: true
  validates :password, length: {minimum: 6, maximum: 120}

  def can_control_users?
    rank == 1
  end

  def can_control_articles?
    rank == 1
  end

end
