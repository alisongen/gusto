class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id', required: true
  enum status: { pending: 0, accepted: 1, decline: 2 }
end
