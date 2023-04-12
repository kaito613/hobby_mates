class BoardsController < ApplicationController

  def index
    @boards = Board.all.order(created_at: :desc)
  end
end
