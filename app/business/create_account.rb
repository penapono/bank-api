# frozen_string_literal: true

class CreateAccount
  def create(name:, accountable_id:, accountable_type:, account_id:, status:, balance:)
    object =
      Account.new(
        name: name, status: status, balance: balance
        accountable_type: accountable_type,
        accountable_id: accountable_id,
        account_id: account_id
      )
    object.save!
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end
end
