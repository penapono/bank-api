# frozen_string_literal: true

FactoryBot.define do
  factory :transfer do
    origin { build(:account) }
    destination { build(:account) }
    ammount 1.0

    trait :invalid do
      origin nil
      destination nil
      ammount nil
    end
  end
end
