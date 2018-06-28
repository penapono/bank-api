# frozen_string_literal: true

class CreateAccount
  def create(name:, accountable_id:, accountable_type:, account_id: nil, status: 0, balance: 0)
    object =
      build_object(
        name, accountable_id, accountable_type, account_id, status, balance
      )
    object.save!
    create_trace(object)
    object
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end

  private

  def build_object(name, accountable_id, accountable_type, account_id, status, balance)
    Account.new.tap do |object|
      object.name = name
      object.status = status
      object.balance = check_balance(balance)
      object.accountable = find_by_type(accountable_type, accountable_id)
      object.account = find_by_type('Account', account_id)
    end
  end

  def check_balance(balance)
    balance.positive? ? balance : 0
  end

  def find_by_type(type, id)
    return nil if type.blank? || id.blank?
    Object.const_get(type.to_s).where(id: id).first
  end

  def create_trace(traceable)
    traceable.reload
    CreateHistory.new.create(
      destination_id: traceable.id,
      traceable_id: traceable.id,
      traceable_type: traceable.class
    )
  end
end
