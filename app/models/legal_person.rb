# frozen_string_literal: true

class LegalPerson < ApplicationRecord
  # Associations
  has_many :accounts, as: :accountable, dependent: :destroy

  # Validations
  validates :cnpj,
            presence: true

  validate :validate_cnpj

  private

  def validate_cnpj
    errors.add(:cnpj, ' invalido!') unless CNPJ.valid?(cnpj)
  end
end
