class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :likes_count
  has_many :comments, serializer: CommentSerializer
  def likes_count
    object.likes.count
  end
end
