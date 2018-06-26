# frozen_string_literal: true
require 'cpf_cnpj'

FactoryBot.define do
  factory :legal_person do
    cnpj CNPJ.generate(true)
    sequence(:social_name) { |n| "SOCIAL BANK S.A. #{n}" }
    sequence(:fantasy_name) { |n| "Hub Card #{n}" }

    trait :invalid do
      cnpj nil
    end
  end
end
