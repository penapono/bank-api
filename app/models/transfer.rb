# frozen_string_literal: true

class Transfer < ApplicationRecord
  # Associations
  belongs_to :origin, class_name: 'Account'
  belongs_to :destination, class_name: 'Account'
  has_many :histories, as: :traceable, dependent: :destroy

  # Validations
  # Validations
  validates :origin,
            :destination,
            :ammount,
            presence: true
end
