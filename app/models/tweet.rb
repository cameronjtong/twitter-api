class Tweet < ApplicationRecord
  validates_presence_of :user_id
  validates :content, presence: true, length: {maximum: 140}
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
end
