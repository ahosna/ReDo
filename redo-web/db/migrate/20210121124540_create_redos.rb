class CreateRedos < ActiveRecord::Migration[6.1]
  def change
    create_table :redos do |t|
      t.integer :type
      t.integer :version
      t.text :key
      t.timestamps
    end
  end
end
