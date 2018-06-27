# frozen_string_literal: true

class NaturalPerson < ApplicationRecord
  # Associations
  has_many :accounts, as: :accountable, dependent: :destroy

  # Validations
  validates :cpf,
            presence: true

  validate :validate_cpf

  private

  def validate_cpf
    errors.add(:cpf, ' invalido!') unless CPF.valid?(cpf)
  end
end
