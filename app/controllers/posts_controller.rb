class PostsController < ApplicationController
	before_action :authenticate_user!
  before_action :init_post, only: [:show, :like]

  def index
    @posts = current_user.timeline
    render json: @posts, status: 200
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      render json: { post: @post }, status: 200
    else
      render json: { errors: @post.errors }, status: 200
    end
  end

  def show
    render json: { post: @post }, status: 200
  end

  def like
    @post.likes.create(user_id: current_user.id)
    render json: { message: 'Success' }, status: 200
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def init_post
    @post = Post.find_by_id(params[:id])
  end
end
