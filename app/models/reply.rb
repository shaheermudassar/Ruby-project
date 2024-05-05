# frozen_string_literal: true

class Reply < ApplicationRecord
  belongs_to :replyable, polymorphic: true
  belongs_to :user
  validates :body, presence: true, length: { minimum: 2 }
end
