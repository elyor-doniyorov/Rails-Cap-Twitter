class FollowingsController < ApplicationController
  def follow_user
    user = User.find(params[:id])
    current_user.follow_user(params[:id])
    redirect_to user_path(params[:id])
    flash[:notice] = "You are now following #{user.fullname} / @#{user.username}"
  end

  def destroy_user
    user = User.find(params[:followerid])
    @friendship = Following.find_by(followerid: params[:followedid])
    @friendship.destroy
    redirect_to user_path(params[:followerdid])
  end
end
