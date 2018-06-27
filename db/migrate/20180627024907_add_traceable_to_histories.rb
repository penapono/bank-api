class AddTraceableToHistories < ActiveRecord::Migration[5.2]
  def change
    add_reference :histories, :traceable, polymorphic: true
  end
end
