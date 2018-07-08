class User < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  before_save :lowercase_email
  validates :email, presence: true, 
                     length: { maximum: 255 },
                     format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  has_many :subscriptions, foreign_key: "follower_id", dependent: :destroy

  has_many :from_subscriptions, class_name:  "Subscription",
                                foreign_key: "follower_id",
                                dependent:   :destroy

  has_many :following, through: :from_subscriptions, source: :followed

  has_many :to_subscriptions, class_name: "Subscription",
                              foreign_key: "followed_id",
                              dependent: :destroy

  has_many :followers, through: :to_subscriptions, source: :follower
  has_many :posts, dependent: :destroy

  def follow(other_user)
    from_subscriptions.create!(followed_id: other_user.id)
  end

  def unfollow(other_user)
    from_subscriptions.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Post.from_users_followed_by(self)
  end

  private

    def lowercase_email
      self.email = email.downcase
    end
end