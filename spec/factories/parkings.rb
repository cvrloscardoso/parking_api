FactoryBot.define do
  factory :parking do
    association :vehicle

    paid { false }
    entry_time { DateTime.current - 1.hour }

    trait :paid do
      paid { true }
    end
  end
end
