# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  def create?
    @user.normal_user? || @user.moderator? || @user.admin?
  end

  def destroy?
    (@user.normal_user? && @user == @record.user) || (@user.moderator? && @user == @record.user) || @user.admin?
  end
end
