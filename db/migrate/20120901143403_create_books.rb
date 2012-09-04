class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|

      t.timestamps
      t.string :name
    end
    add_index :books, :name, :name => 'idx_books_name'
  end
end
