# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    @user.normal_user? || @user.moderator? || @user.admin?
  end

  def create?
    @user.normal_user? || @user.moderator? || @user.admin?
  end

  def edit?
    (@user.normal_user? && @user == @record.user) || @user.admin? || @user.moderator?
  end

  def update?
    (@user.normal_user? && @user == @record.user) || @user.admin? || @user.moderator?
  end

  def destroy?
    (@user.normal_user? && @user == @record.user) || @user.admin? || @user.moderator?
  end
end
