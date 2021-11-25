class CommentSerializer < ActiveModel::Serializer
  attributes :body, :likes_count

  def likes_count
    object.likes.count
  end
end
