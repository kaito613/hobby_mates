class CommentsController < ApplicationController
  
  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  def create
    if current_user.nil?
      redirect_to user_session_path
      return
    end
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      redirect_to comments_path
    else
      redirect_to new_comment_path
    end
  end

  def new
    @comment = Comment.new
  end

  def edit
    if current_user.nil?
      redirect_to user_session_path
      return
    end
    
    @comment = Comment.find_by(id: params[:id])

    if @comment.nil?
      redirect_to new_comment_path
      return
    end

    unless current_user.id == @comment.user_id
      redirect_to new_comment_path
    end
  end
  
  def show
    @comment = Comment.find_by(id: params[:id])

    if @comment.nil?
      redirect_to comments_path
    end
  end

  def update
    return if current_user.nil?

    @comment = Comment.find_by(id: params[:id])

    return if @comment.nil?

    if current_user.id == @comment.user_id
      @comment.update!(comment_params)
      redirect_to comments_path
    end
  end

  def destroy
    return if current_user.nil?

    @comment = Comment.find_by(id: params[:id])

    return if @comment.nil?

    if current_user.id == @comment.user_id
      @comment.destroy!
      redirect_to comments_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit( :message, :board_id )
  end
end