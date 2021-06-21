class Opinion < ApplicationRecord
  belongs_to :author, class_name: 'User'
  validates :text, presence: true, length: { maximum: 260 }
  has_many :likes, dependent: :destroy
  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :newsfeed_opinions, -> { includes(:author).ordered_by_most_recent }
end
