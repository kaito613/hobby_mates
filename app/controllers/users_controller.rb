class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    if current_user.nil?
      @is_user_in_mypage = false
    else
      @is_user_in_mypage = current_user.current_user_in_mypage(params[:id])
    end
  end

  def index
    unless current_user
      @users = User.all
    else
      @users = User.where.not(id: current_user.id)
    end
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
end
