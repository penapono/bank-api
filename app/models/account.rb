# frozen_string_literal: true

class Account < ApplicationRecord
  # Organize accounts like a tree
  has_ancestry

  # Associations
  belongs_to :accountable, polymorphic: true
  belongs_to :account, optional: true
  has_many :accounts, dependent: :destroy
  has_many :histories, as: :traceable, dependent: :destroy

  # Enums
  enum status: { active: 0, blocked: 1, canceled: 2 }

  # Validations
  validates :name,
            :status,
            :balance,
            :accountable_type,
            :accountable_id,
            :accountable,
            presence: true
end
