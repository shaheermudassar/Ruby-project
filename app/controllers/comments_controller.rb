# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    authorize Comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    flash[:notice] = if @comment.save
                       'Commented successfully'
                     else
                       'Comment not created'
                     end
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_body, :photo).merge(user_id: current_user.id)
  end
end
