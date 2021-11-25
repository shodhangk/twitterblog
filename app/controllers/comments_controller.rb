class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :init_post, only: [:show]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      render json: { message: 'Success' }, status: 200
    else
      render json: { errors: @comment.errors }, status: 200
    end
  end

  def like
    @comment.likes.create(user_id: current_user.user_id)
    render json: { message: 'Success' }, status: 200
  end

  private

  def comment_params
    params.permit(:body, :post_id)
  end

  def init_post
    @post = Post.find_by_id(params[:id])
  end
end
