class Post < ApplicationRecord
  belongs_to :user
  has_many :comments,  dependent: :destroy
  has_many :likes, as: :likeable,  dependent: :destroy
  has_and_belongs_to_many :hashtags

  validates :title, presence: true
  validates :body, presence: true
  validates_length_of :body, maximum: 140

  scope :latest_posts, ->(user_ids) { where(user_id: user_ids).order(created_at: :desc) }

  after_create do
    # Detects hashtags typed into body
    extracted_hashtags = body.scan(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i)
    extracted_hashtags.flatten.uniq.map do |hashtag|
      # Hashtag is at the beginning #Save after removing
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase)
      hashtags << tag
    end
  end
  # Update action
  before_update do
    hashtags.clear
    hashtags = body.scan(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i)
    hashtags.flatten.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase)
      hashtags << tag
    end
  end
end
