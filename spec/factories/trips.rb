FactoryBot.define do
  factory :trip do
    status { 'ready' }

    trait :with_invalid_status do
      status { 'invalid_status' }
    end

    trait :with_ongoing_status do
      status { 'ongoing' }
    end

    trait :with_completed_status do
      status { 'completed' }
    end
  end
end
