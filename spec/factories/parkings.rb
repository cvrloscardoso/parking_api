FactoryBot.define do
  factory :parking do
    association :vehicle

    paid { false }
    entry_time { DateTime.current - 1.hour }

    trait :paid do
      paid { true }
      exit_time { DateTime.current }
    end
  end
end
