class AddBalanceToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :balance, :float, default: 0.0
  end
end
