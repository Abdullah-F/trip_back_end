FactoryBot.define do
  factory :location do
    lat { "#{Faker::Address.latitude}" }
    lng { "#{Faker::Address.longitude}" }

    trait :with_a_trip do
      trip
    end

    trait :with_a_trip_id do
      trip_id { Faker::Number.number(digits: 2) }
    end

    trait :with_a_string_trip_id do
      trip_id { "#{Faker::Number.number(digits: 2)}" }
    end
  end
end
