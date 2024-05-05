# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report

  def create
    authorize Report
    @report = @reportable.reports.new(user_id: current_user.id)
    flash[:notice] = if @report.save
                       'Reported successfully'
                     else
                       'Report not successful'
                     end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_report
    @reportable = if params[:article_id]
                    Article.find_by(id: params[:article_id])
                  elsif params[:comment_id]
                    Comment.find_by(id: params[:comment_id])
                  end
  end
end
