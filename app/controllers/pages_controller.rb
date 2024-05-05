# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_article, only: %i[edit]
  def index
    @articles = Article.all.order('updated_at DESC')
  end

  def edit
    if current_user.role && @article.user.role == 'moderator'
      flash[:alert] = t(:publish_fail)
    else
      update_article(@article)
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def update_article(_article)
    @updated_article = @article.update(status: params[:status])
    if @updated_article
      flash[:notice] = "Article successfully #{params[:status]}"
    else
      flash[:alert] = t(:publish_failed)
    end
  end
end
