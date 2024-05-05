# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: { admin: 0, moderator: 1, normal_user: 2 }

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  validates :email, format: { with: Devise.email_regexp }
  validates :first_name, presence: true, length: { in: 2..20 }
  validates :last_name, presence: true, length: { in: 2..20 }
  validates :phone, presence: true, length: { is: 9 }

  after_initialize do
    self.role ||= :normal_user if new_record?
  end
end
