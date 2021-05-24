class CreateRedos < ActiveRecord::Migration[6.1]
  def change
    create_table :redos do |t|
      t.integer :hw_type
      t.integer :version
      t.text :shared_key
      t.timestamps
    end
  end
end
