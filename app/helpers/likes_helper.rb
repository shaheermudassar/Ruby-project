# frozen_string_literal: true

module LikesHelper
  def content_liked(likeableid, likeabletype)
    Like.find_by(likeable_id: likeableid, likeable_type: likeabletype, user_id: current_user.id)
  end
end
