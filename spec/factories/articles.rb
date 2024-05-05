# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    association :user
    title { Faker::Lorem.characters(number: 100) }
    description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    image { Rack::Test::UploadedFile.new('./spec/files/img1.png', 'image/png') }

    trait :publish do
      status { :publish }
    end
  end
end
