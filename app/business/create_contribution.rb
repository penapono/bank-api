# frozen_string_literal: true

class CreateContribution
  def create(uid:, ammount:, account_id:)
    object =
      build_object(
        uid, ammount, account_id
      )
    object.save!
    create_trace(object)
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end

  private

  def build_object(uid, ammount, account_id)
    account = find_by_type('Account', account_id)
    check_account_eligibility(account) unless account.blank?
    check_ammount(ammount)
    move_account(account, ammount)
    Contribution.new.tap do |object|
      object.uid = uid
      object.ammount = ammount
      object.account = account
    end
  end

  def check_account_eligibility(account)
    raise StandardError, 'Conta filha nao pode receber aporte!' unless account.root?
    raise StandardError, 'Conta em estado invalido para aporte!' unless account.active?
  end

  def check_ammount(ammount)
    raise StandardError, 'Quantia invalida para aporte!' unless ammount.positive?
  end

  def move_account(account, ammount)
    account.credit(ammount)
  end

  def find_by_type(type, id)
    return nil if type.blank? || id.blank?
    Object.const_get(type.to_s).where(id: id).first
  end

  def create_trace(traceable)
    traceable.reload
    CreateHistory.new.create(
      uid: traceable.uid,
      destination_id: traceable.account.id,
      traceable_id: traceable.id,
      traceable_type: traceable.class
    )
  end
end
