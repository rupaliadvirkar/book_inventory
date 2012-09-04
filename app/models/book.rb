class Book < ActiveRecord::Base
  # Add HABTM relation  with authors
  has_and_belongs_to_many :authors
  
  #comments
  acts_as_commentable
  
  
  attr_accessor :author_names
  
  validates :name, :presence => :true
  
  validates :author_names, :presence => :true
  
  validate :check_author_names
  
  before_create :add_authors
  
  
  #This method will make sure of valid author names
  def check_author_names
    if self.errors[:author_names].empty?
      inserted_author_name = self.author_names.split(',')
      inserted_author_name.collect!{|ia| ia.strip}      
      if inserted_author_name.empty? or inserted_author_name.include?("")
        self.errors.add(:author_names, 'are not entered properly. Please check again.')        
      else  
        for a_name in inserted_author_name
          if /[\,\"\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~0-9]/.match(a_name)
            self.errors.add(:author_names, 'name should not contain any special characters or numbers.')
            return
          end
        end
      end
    end
  end
  
  #This method checks the duplicity of authors and book name. 
  #If book name with same authors exists then raise an error.
  #If they exist already then assign to the book. 
  #If not create them and assign to the book
  def add_authors
    authors_array = []
    fetched_authors_array = self.author_names.split(',')
    #downcase fetched authors name
    authors_array = fetched_authors_array.collect{|ia| ia.strip.downcase}
    #query to find uniqueness of authors
    existing_authors = Author.where("lower(name) in (?)", authors_array).includes(:books)
    name_duplicate_flag = self.is_name_duplicate?
    author_duplicate_flag = self.all_authors_are_same?(authors_array, existing_authors)
    if name_duplicate_flag and author_duplicate_flag
      for exist_author in existing_authors
        if exist_author.books.detect{|book| book.name.downcase == self.name.downcase}
          raise(InvalidBook,"Book already exists")
        end 
      end 
    end
    counter = 0
    for author_name in authors_array
      author = existing_authors.detect{|a| a.name.downcase == author_name}
      if author
        self.authors << author
      else
        #vlidation is skipped as its already checking for the things here. So saving query for uniqueness validation in authors
        self.authors << Author.new(:name => fetched_authors_array[counter])
      end
      counter += 1      
    end
  end
  
  #This method will check if book with same name is present or not. validates :name, :uniquenss => true cant be use. Because its scope with respect to authors to be checked
  #As its HABTM realationship...hook has to added manually to use itr in other method.
  def is_name_duplicate?
    Book.where("lower(name) in (?)", self.name.downcase) ? true : false 
  end
  
  #To check authirs are not same as existing book 
  def all_authors_are_same?(new_authors, existing_authors)
    flag = false
    for author_name in new_authors
      if existing_authors.detect{|e_name| e_name.name.downcase == author_name}
        flag = true
      else   
        flag = false
      end
    end
    flag
  end
  
end
