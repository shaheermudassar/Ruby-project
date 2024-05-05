# frozen_string_literal: true

class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_replyable

  def create
    authorize Reply
    @reply = @replyable.replies.new(body: reply_params[:body], user_id: current_user.id)
    flash[:notice] = if @reply.save
                       'Replied successfully'
                     else
                       'Replied not successful'
                     end
    redirect_back(fallback_location: root_path)
  end

  private

  def reply_params
    params.require(:reply).permit(:body)
  end

  def set_replyable
    @replyable = if params[:comment_id]
                   Comment.find_by(id: params[:comment_id])
                 elsif params[:suggestion_id]
                   Suggestion.find_by(id: params[:suggestion_id])
                 end
  end
end
