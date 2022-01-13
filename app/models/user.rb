class User < ApplicationRecord
  def self.digest(token)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(token, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  before_save { username.downcase }
  validates :username,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
