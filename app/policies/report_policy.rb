# frozen_string_literal: true

class ReportPolicy < ApplicationPolicy
  def create?
    @user.normal_user? || @user.moderator? || @user.admin?
  end
end
