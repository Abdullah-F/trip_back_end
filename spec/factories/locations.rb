FactoryBot.define do
  factory :location do
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }

    trait :with_a_trip do
      trip
    end
  end
end
