# frozen_string_literal: true

class Account < ApplicationRecord
  # Associations
  belongs_to :accountable, polymorphic: true
  has_many :accounts, dependent: :destroy

  # Enums
  enum status: { active: 0, blocked: 1, canceled: 2 }

  # Validations
  validates :name,
            :status,
            :created_at,
            :accountable_type,
            :accountable_id,
            :accountable,
            presence: true
end
