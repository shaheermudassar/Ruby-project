# frozen_string_literal: true

class ReplyPolicy < ApplicationPolicy
  def create?
    @user.normal_user? || @user.moderator? || @user.admin?
  end
end
