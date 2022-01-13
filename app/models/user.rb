class User < ApplicationRecord
  before_save { email.downcase }
  validates :username,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false }
end
