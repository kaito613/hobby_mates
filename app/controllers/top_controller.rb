class TopController < ApplicationController

  def home
    @boards = Board.all.order(created_at: :desc)
  end
end
