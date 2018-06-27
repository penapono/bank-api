# frozen_string_literal: true

class History < ApplicationRecord
  # Associations
  belongs_to :origin, class_name: 'Account', optional: true
  belongs_to :destination, class_name: 'Account'
  belongs_to :traceable, polymorphic: true

  # Validations
  # Validations
  validates :destination,
            :traceable,
            :traceable_id,
            :traceable_type,
            presence: true
end
