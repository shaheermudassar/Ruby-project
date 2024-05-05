# frozen_string_literal: true

module PagesHelper
  def report_articles(articles)
    articles.joins(:reports).order('updated_at DESC')
  end
end
