# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:likeable) }
  end
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to([:likeable_id, :likeable_type]) }
  end
end
