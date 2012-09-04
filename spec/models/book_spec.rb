require 'spec_helper'

describe Book do
 it "should be invalid without name" do
   book = Book.new
   book.author_names = 'Test Test'
   book.should_not be_valid
   book.errors[:name][0].should == "can't be blank"
   book.name = 'Test1'
   book.should be_valid
 end

 it "should be invalid without author names" do
   book = Book.new
   book.name = 'Test1'
   book.should_not be_valid
   book.errors[:author_names][0].should == "can't be blank"
   book.author_names = 'Test Test'
   book.should be_valid
 end
 
 it "should be invalid with numeric/special character author names" do   
   book = Book.new
   book.name = 'Test1'
   book.author_names = 'Test2323$%%'
   book.should_not be_valid   
   book.errors[:author_names][0].should == "name should not contain any special characters or numbers."
   book.author_names = 'Test F. Test'
   book.should be_valid
 end

 it "should be valid with author names separated by comma" do
   book = FactoryGirl.create(:new_book)
   book.authors.length.should == 2 
 end
 
 it "should add given book comment" do
   book = FactoryGirl.create(:book)
   comment = FactoryGirl.create(:comment, :commentable => book)
   comment.commentable_id.should == book.id
   comment.commentable_type.to_s.should == 'Book'
 end
end
