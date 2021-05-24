class AddSerialToRedos < ActiveRecord::Migration[6.1]
  def change
    add_column :redos, :serial, :string
  end
end
