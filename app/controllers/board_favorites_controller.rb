class BoardFavoritesController < ApplicationController

  def index
    @board_favorites = BoardFavorite.where(user_id: params[:user_id])
  end

  def create
    board_favorite = BoardFavorite.new(create_params)
    board_favorite.save
    redirect_to request.referrer || root_path
  end

  def destroy
    board_favorite = BoardFavorite.find(params[:id])
    board_favorite.destroy!
    redirect_to request.referrer || root_path
  end

  private

  def create_params
    params.require(:board_favorite).permit(:board_id).merge(user_id: current_user.id)
  end
end