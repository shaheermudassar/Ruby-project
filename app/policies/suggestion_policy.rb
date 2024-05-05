# frozen_string_literal: true

class SuggestionPolicy < ApplicationPolicy
  def create?
    @user.normal_user? || @user.moderator? || @user.admin?
  end

  def destroy?
    @user.normal_user? || @user.admin?
  end
end
