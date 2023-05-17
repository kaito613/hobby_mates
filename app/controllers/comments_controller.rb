class CommentsController < ApplicationController
  
  def create
    if current_user.nil?
      redirect_to user_session_path
      return
    end

    @board  = Board.find(params[:board_id])
    
    @comment = Comment.new(create_comment_params)


    if @comment.save
      redirect_to board_path(@board)
    else
      redirect_to board_path(@board)
    end
  end

  def edit
    if current_user.nil?
      redirect_to user_session_path
      return
    end
    
    @comment = Comment.find_by(id: params[:id])

    if @comment.nil?
      redirect_to boards_path
      return
    end

    unless current_user.id == @comment.user_id
      redirect_to boards_path
    end
  end
  
  def show
    @comment = Comment.find_by(id: params[:id])

    if @comment.nil?
      redirect_to boards_path
    end
  end

  def update
    return if current_user.nil?

    @comment = Comment.find_by(id: params[:id])

    return if @comment.nil?

    if current_user.id == @comment.user_id
      @comment.update!(update_comment_params)
      redirect_to board_path
    end
  end

  def destroy
    return if current_user.nil?

    @comment = Comment.find_by(id: params[:id])

    return if @comment.nil?

    if current_user.id == @comment.user_id
      @comment.destroy!
      redirect_to board_path
    end
  end

  private

  def update_comment_params
    params.require(:comment).permit(:message, :board_id)
  end

  def create_comment_params
    # paramsの中のcommentキーのmessageを許可している。それにboard_idとuser_idをキーに指定しparamsのboard_idとcurrent_user.idを値として渡している。
    params.require(:comment).permit(:message).merge( board_id: params[:board_id], user_id: current_user.id)
  end
end