class Cafe < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy # If you want cafes to have associated posts
  # (Optional) Add other relationships if needed

  # Validations
  validates :name, :address, presence: true
end
