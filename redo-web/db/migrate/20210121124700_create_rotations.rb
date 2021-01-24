class CreateRotations < ActiveRecord::Migration[6.1]
  def change
    create_table :rotations do |t|
      t.timestamps
    end
  end
end
