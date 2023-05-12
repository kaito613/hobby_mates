class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    following = current_user.following_relationships.build(create_params)
    following.save
    redirect_to request.referrer || root_path
  end

  def destroy
    following = current_user.following_relationships.find_by(follower_id: params[:user_id]) 
    following.destroy
    redirect_to request.referrer || root_path
  end

  private

  def create_params
    params.merge(follower_id: params[:user_id]).permit(:follower_id)
  end
end
