class AddIndexes < ActiveRecord::Migration[6.1]
  def change
    add_reference :faces, :redo, foreign_key: true
    add_reference :redos, :redo, foreign_key: true
    add_reference :redos, :face, foreign_key: true
  end
end
