class User < ApplicationRecord
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end

    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end
  attr_accessor :login_token

  before_save { username.downcase }
  validates :username,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def login
    self.login_token = User.new_token
    update_attribute(:login_digest, User.digest(login_token))
  end

  def authenticated?(login_token)
    BCrypt::Password.new(login_digest).is_password?(login_token)
  end

  def logged_in?
    login_token.nil? && login_digest.nil?
  end
end
