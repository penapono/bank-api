# frozen_string_literal: true

class NaturalPerson < ApplicationRecord
  # Associations
  has_many :accounts, as: :accountable, dependent: :destroy

  # Validations
  validates :cpf,
            presence: true
end
