class AddAccountToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_reference :accounts, :account, foreign_key: true, index: true
  end
end
