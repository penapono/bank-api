# frozen_string_literal: true

class RollbackTransfer
  def rollback(transfer_id:)
    rollback_transfer(transfer_id)
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end

  private

  def rollback_transfer(transfer_id)
    transfer = load_transfer(transfer_id)
    origin_id = transfer.destination.id
    destination_id = transfer.origin.id
    ammount = transfer.ammount
    CreateTransfer.new.create(origin_id: origin_id, destination_id: destination_id, ammount: ammount)
  end

  def load_transfer(transfer_id)
    transfer = Transfer.where(id: transfer_id).first
    raise StandardError, 'Transferencia a ser revertida nao encontrada!' if transfer.blank?
    transfer
  end
end
