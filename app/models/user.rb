# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :follower_relationships, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followed_users, through: :follower_relationships, source: :follower
  has_many :followed_relationships, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :followed_relationships, source: :followed
  has_many :cafes, dependent: :destroy

  # ActiveStorage for profile picture
  has_one_attached :image

  # Methods to handle following and unfollowing users
  def follow(user)
    # Reversed logic: we want to associate the current user as "followed"
    self.followed_users << user unless self == user
  end

  def unfollow(user)
    # Reversed logic: we want to remove the association as followed
    self.followed_users.delete(user)
  end

  # Helper method to check if the user is following someone (reversed logic here too)
  def following?(user)
    # Reverse check: if current user is NOT the follower, but is being followed
    followed_users.include?(user)
  end
end
