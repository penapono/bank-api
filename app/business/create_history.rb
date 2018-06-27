# frozen_string_literal: true

class CreateHistory
  def create(origin_id: nil, destination_id:, uid: nil, traceable_id:, traceable_type:)
    object =
      build_object(
        origin_id, destination_id,
        uid,
        traceable_id, traceable_type
      )
    object.save!
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end

  private

  def build_object(origin_id, destination_id, uid, traceable_id, traceable_type)
    History.new.tap do |object|
      object.origin = find_by_type('Account', origin_id)
      object.destination = find_by_type('Account', destination_id)
      object.uid = uid
      object.traceable = find_by_type(traceable_type, traceable_id)
    end
  end

  def find_by_type(type, id)
    return nil if type.blank? || id.blank?
    Object.const_get(type.to_s).where(id: id).first
  end
end
