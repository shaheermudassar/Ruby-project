# frozen_string_literal: true

module SuggestionsHelper
  def user_suggestions
    current_user.suggestions.nil?
  end
end
