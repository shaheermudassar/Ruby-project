# frozen_string_literal: true

module ArticlesHelper
  def moderator_user
    current_user.role == 'moderator' if signed_in?
  end

  def user_articles
    current_user.articles.nil?
  end

  def user_article(article)
    (!article.nil? && current_user.id == article.user_id) || (current_user.role == 'admin')
  end
end
