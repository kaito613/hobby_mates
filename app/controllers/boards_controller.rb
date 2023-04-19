class BoardsController < ApplicationController

  def new
    @board = Board.new
  end

  def create
    if current_user.nil?
      redirect_to user_session_path
      return
    end
    
    @board = current_user.boards.build(board_params)  
    if @board.save  
      redirect_to board_path(@board)
    else
      redirect_to new_board_path
    end
  end

  def index
    @boards = Board.all.order(created_at: :desc)
  end

  def show
    @board = Board.find_by(id: params[:id])
    
    if @board.nil?
      redirect_to boards_path
    end
  end

  def edit
    if current_user.nil?
      redirect_to user_session_path
      return
    end
    # find_byで検索をかけて存在しないidが代入された場合はnilが返る
    @board = Board.find_by(id: params[:id])

    if @board.nil?
      redirect_to new_board_path 
      return
    end

    if current_user.id != @board.user_id 
      redirect_to new_board_path
    end
  end

  def update
    
    return if current_user.nil?

    @board = Board.find_by(id: params[:id])

    return if @board.nil?

    if current_user.id == @board.user_id
      @board.update(board_params)
      redirect_to board_path(@board)
    end
  end

  def destroy

    return if current_user.nil?

    @board = Board.find_by(id: params[:id])

    return if @board.nil?

    if current_user.id == @board.user_id
      @board.destroy!
      redirect_to boards_path
    end
  end

  private

  def board_params
    params.require(:board).permit( :title, :img, :description)
  end
end
