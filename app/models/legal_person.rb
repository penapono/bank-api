# frozen_string_literal: true

class LegalPerson < ApplicationRecord
  # Validations 
  validates :cnpj,
            presence: true
end
