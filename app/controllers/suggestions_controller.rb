# frozen_string_literal: true

class SuggestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @suggestions = current_user.suggestions
  end

  def create
    authorize Suggestion
    @article = Article.find(params[:article_id])
    @suggestion = @article.suggestions.create(suggest_params)
    flash[:notice] = if @suggestion.save
                       'Suggested successfully'
                     else
                       'Suggestion not successful'
                     end
    redirect_to article_path(@article)
  end

  def destroy
    authorize Suggestion
    @suggestion = Suggestion.find(params[:id])
    flash[:notice] = if @suggestion.destroy
                       'Suggestion deleted successfully'
                     else
                       'Suggestion not deleted successful'
                     end
    redirect_back(fallback_location: root_path)
  end

  private

  def suggest_params
    params.require(:suggestion).permit(:suggest).merge(user_id: current_user.id)
  end
end
