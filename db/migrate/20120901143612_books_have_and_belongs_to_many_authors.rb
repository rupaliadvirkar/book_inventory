class BooksHaveAndBelongsToManyAuthors < ActiveRecord::Migration
  def up
    create_table :authors_books , :id => false do |t|
      t.references :author
      t.references :book
    end
    
    add_index :authors_books, [:author_id,:book_id], :unique => true
  end
  
  def down
  end
end
