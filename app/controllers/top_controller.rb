class TopController < ApplicationController

  def home
    @boards = Board.page(params[:page]).per(5).order(created_at: :desc) 
  end
end
