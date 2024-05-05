# frozen_string_literal: true
class Article < ApplicationRecord 
  
  has_one_attached :image, dependent: :destroy
  enum status: { publish: 0, un_publish: 1 }
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  validates :title, presence: true, length: { in: 6..100 }

  after_initialize do
    self.status ||= :un_publish if new_record?
  end
end
