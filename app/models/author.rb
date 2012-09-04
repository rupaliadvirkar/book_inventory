class Author < ActiveRecord::Base
  # Add HABTM relation  with authors
  has_and_belongs_to_many :books
  
  #comments
  acts_as_commentable

  #This is commented. As this already been taken care in the book.rb
  #If there is seperate form of author then can simply uncomment to use.
  #validations
  #validates :name, :presence => :true, :uniqueness => true
end
