# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  before_action :set_likes

  def new
    authorize @like
  end

  def create
    @like = @likeable.likes.new(user_id: current_user.id)
    flash[:notice] = if @like.save
                       'Liked successfully'
                     else
                       'Like not'
                     end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like
    flash[:notice] = if @like.destroy
                       'Unliked'
                     else
                       'Unliked not succesful.'
                     end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_likes
    @likeable = if params[:article_id]
                  Article.find(params[:article_id])
                elsif params[:comment_id]
                  Comment.find(params[:comment_id])
                end
  end
end
