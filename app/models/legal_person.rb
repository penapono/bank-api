# frozen_string_literal: true

class LegalPerson < ApplicationRecord
  # Associations
  has_many :accounts, as: :accountable, dependent: :destroy
  
  # Validations 
  validates :cnpj,
            presence: true
end
