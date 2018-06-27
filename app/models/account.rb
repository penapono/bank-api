class Account < ApplicationRecord
  # Associations
  belongs_to :accountable, polymorphic: true

  # Validations
  validates :name,
            :created_at,
            :accountable_type,
            :accountable_id,
            :accountable,
            presence: true
end
