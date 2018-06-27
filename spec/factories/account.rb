# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "CONTA #{n}" }
    status 0
    balance 0.0
    accountable { create(:natural_person) }
    created_at Date.today

    trait :invalid do
      name nil
      status nil
      balance nil
      accountable nil
    end

    trait :child do
      account { create(:account) }
    end
  end
end
