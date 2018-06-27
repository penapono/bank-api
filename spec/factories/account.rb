# frozen_string_literal: true
require 'cpf_cnpj'

FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "CONTA #{n}" }
    accountable { create(:natural_person) }
    created_at DateTime.now 
    
    trait :invalid do
      name nil
      accountable nil
    end
  end
end
