# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  caption    :string
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  # Validations
  validates :image, presence: true
  validates :caption, presence: true
end
