# frozen_string_literal: true

class CreateTransfer
  def create(origin_id:, destination_id:, ammount: 0)
    object =
      build_object(
        origin_id, destination_id, ammount
      )
    object.save!
    create_trace(object)
    object
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end

  private

  def build_object(origin_id, destination_id, ammount)
    origin = find_by_type('Account', origin_id)
    destination = find_by_type('Account', destination_id)
    check_accounts(origin, destination, ammount)
    move_accounts(origin, destination, ammount)
    Transfer.transaction do
      Transfer.new.tap do |object|
        object.origin = origin
        object.destination = destination
        object.ammount = ammount
      end
    end
  end

  def check_ammount(ammount)
    raise StandardError, 'Quantia invalida para transferencia!' unless ammount.positive?
  end

  def check_accounts(origin, destination, ammount)
    raise StandardError, 'Conta origem e destino iguais!' if origin.id == destination.id
    check_balance(origin, ammount)
    check_accounts_status(origin, destination)
  end

  def move_accounts(origin, destination, ammount)
    Account.transaction do
      origin.debit(ammount)
      destination.credit(ammount)
    end
  end

  def check_balance(origin, ammount)
    check_ammount(ammount)
    raise StandardError, 'Saldo insuficiente na conta de origem!' if origin.balance < ammount
  end

  def check_accounts_status(origin, destination)
    raise StandardError, 'Situacao da conta de origem invalida' unless origin.active?
    raise StandardError, 'Situacao da conta de destino invalida' unless destination.active?
  end

  def find_by_type(type, id)
    return nil if type.blank? || id.blank?
    Object.const_get(type.to_s).where(id: id).first
  end

  def create_trace(traceable)
    traceable.reload
    CreateHistory.new.create(
      origin_id: traceable.origin.id,
      destination_id: traceable.destination.id,
      traceable_id: traceable.id,
      traceable_type: traceable.class
    )
  end
end
