# frozen_string_literal: true

class NaturalPerson < ApplicationRecord
  # Validations
  validates :cpf,
            presence: true
end
