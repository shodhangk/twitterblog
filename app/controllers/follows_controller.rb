class FollowsController < ApplicationController
  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    render json: { message: 'Success' }, status: 200
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    render json: { message: 'Success' }, status: 200
  end
end
