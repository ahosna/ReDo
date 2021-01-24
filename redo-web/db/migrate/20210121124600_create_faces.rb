class CreateFaces < ActiveRecord::Migration[6.1]
  def change
    create_table :faces do |t|
      t.text :text
      t.integer :status
      t.timestamps
    end
  end
end
