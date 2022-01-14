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
    loop do
      random_token = SecureRandom.urlsafe_base64
      return random_token unless User.exists?(login_digest: User.digest(random_token))
    end
  end
  attr_accessor :login_token

  before_save { username.downcase }
  validates :username,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :tweets
  validates :password, presence: true, length: { minimum: 6 }

  def login
    self.login_token = User.new_token
    update_attribute(:login_digest, User.digest(login_token))
  end

  def authenticated?(login_token)
    BCrypt::Password.new(login_digest).is_password?(login_token)
  end
end
