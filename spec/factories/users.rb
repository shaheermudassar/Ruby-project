# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::Number.number(digits: 9) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    confirmed_at { DateTime.now }

    trait :moderator do
      role { :moderator }
    end

    trait :admin do
      role { :admin }
    end
  end
end
