# frozen_string_literal: true

class CreateContribution
  def create(uid:, ammount:, account_id:)
    object =
      Contribution.new(
        uid: uid, ammount: ammount,
        account_id: account_id
      )
    object.save!
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end
end
