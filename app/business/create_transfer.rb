# frozen_string_literal: true

class CreateTransfer
  def create(origin_id:, destination_id:, ammount:)
    transfer =
      Transfer.new(
        origin_id: origin_id,
        destination_id: destination_id,
        ammount: ammount
      )
    transfer.save!
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end
end
