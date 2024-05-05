# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    association :user
    association :reportable, factory: :article
  end
end
