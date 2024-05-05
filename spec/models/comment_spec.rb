# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:article) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
    it { is_expected.to have_many(:replies).dependent(:destroy) }
    it { is_expected.to have_one_attached(:photo) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:comment_body) }
  end
end
