class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    if current_user.nil?
      @is_user_in_mypage = false
    else
      @is_user_in_mypage = current_user.current_user_in_mypage(params[:id])
    end
  end
end
