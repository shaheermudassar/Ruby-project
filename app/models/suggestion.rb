# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :replies, as: :replyable, dependent: :destroy
end
