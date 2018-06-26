# frozen_string_literal: true
require 'cpf_cnpj'

FactoryBot.define do
  factory :natural_person do
    cpf CPF.generate(true)
    sequence(:name) { |n| "Pessoa Física #{n}" }
    birth DateTime.now

    trait :invalid do
      cpf nil
    end
  end
end
