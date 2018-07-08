class Post < ApplicationRecord
  mount_uploader :image_url, ImageUploader

  belongs_to :user

  validates :user_id, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM subscriptions
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end