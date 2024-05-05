# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:articles).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
    it { is_expected.to have_many(:replies).dependent(:destroy) }
    it { is_expected.to have_many(:suggestions).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(2).is_at_most(20) }

    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(20) }

    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_length_of(:phone).with_message('must be between of 6 to 9 characters.') }
  end
end
