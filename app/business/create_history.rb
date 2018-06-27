# frozen_string_literal: true

class CreateHistory
  def create(origin_id:, destination_id:, uid:, traceable_id:, traceable_type:)
    object =
      History.new(
        origin_id: origin_id, destination_id: destination_id,
        uid: uid,
        traceable_id: traceable_id, traceable_type: traceable_type
      )
    object.save!
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end
end
