class CommentsController < ApplicationController

  def index
    @comments = Comment.all.order(created_at: :desc)
  end
end
