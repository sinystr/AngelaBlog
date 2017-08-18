class User < ActiveRecord::Base
  validates :email, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :name, length: { minimum: 6, maximum: 120 }
  validates :password, presence: true
  validates :password_salt, presence: true

  has_many :comments

  def admin?
    rank == 1
  end

  def password_valid?(password)
    !password.empty? && password.length < 32 && password.length >= 6
  end

  def password_to_be_hashed=(password)
    self.password_salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def is_password_correct?(password)
    self.password == BCrypt::Engine.hash_secret(password, password_salt)
  end
end
