class Follow < ApplicationRecord
    belongs_to :followers, class_name: 'User', foreign_key: :follower_id
    belongs_to :followees, class_name: 'User', foreign_key: :followee_id

    validates :follower_id, uniqueness: { scope: :followee_id }
    validates :followee_id, uniqueness: { scope: :follower_id }
end
