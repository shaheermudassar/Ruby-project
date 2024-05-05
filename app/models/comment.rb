# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  has_one_attached :photo, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :replies, as: :replyable, dependent: :destroy
  validates :comment_body, presence: true, if: :check_photo
  validates :photo, content_type: %i[png jpg jpeg], if: :attach_photo

  private

  def check_photo
    photo.attached? == false
  end

  def attach_photo
    photo.attached? == true
  end
end
