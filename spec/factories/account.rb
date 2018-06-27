# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "CONTA #{n}" }
    accountable { create(:natural_person) }
    created_at Date.today

    trait :invalid do
      name nil
      accountable nil
    end
  end
end
