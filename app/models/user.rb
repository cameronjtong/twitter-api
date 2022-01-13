class User < ApplicationRecord
  before_save { username.downcase }
  validates :username,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false }
  has_secure_password
end
