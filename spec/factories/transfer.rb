# frozen_string_literal: true

FactoryBot.define do
  factory :transfer do
    origin_id { create(:account).id }
    destination_id { create(:account).id }
    ammount 1.0

    trait :invalid do
      origin nil
      destination nil
      ammount nil
    end
  end
end
