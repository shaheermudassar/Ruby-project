# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :user
    association :article
    comment_body { Faker::Lorem.words(number: rand(2..10)) }
    photo { Rack::Test::UploadedFile.new('./spec/files/img1.png', 'image/png') }
  end
end
