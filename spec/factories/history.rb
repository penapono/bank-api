# frozen_string_literal: true

FactoryBot.define do
  factory :history do
    destination { build(:account) }
    traceable { create(:transfer) }

    trait :invalid do
      destination nil
      traceable nil
    end
  end
end
