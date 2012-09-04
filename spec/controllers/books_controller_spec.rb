require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BooksController do
  before(:each) do
      @user = FactoryGirl.create(:user)
  end
  describe "GET 'show'" do    
    it "should be successful for admin user to comment on it" do
      role = FactoryGirl.create(:role)
      @book = FactoryGirl.create(:book)
      @user.roles << role
      sign_in @user
      get :show, :id => @book.id
      response.should be_success
    end
    
    it "should be successful normal user to comment on it" do
      role = FactoryGirl.create(:normal_user)
      @book = FactoryGirl.create(:book)
      @user.roles << role
      sign_in @user
      get :show, :id => @book.id
      response.should be_success
    end
  end
  
  describe "GET 'new'" do    
    it "should be successful for admin user" do
      role = FactoryGirl.create(:role)
      @user.roles << role
      sign_in @user
      get :new
      response.should be_success
    end
    
    it "should not be successful for normal user" do
      role = FactoryGirl.create(:normal_user)
      @user.roles << role
      sign_in @user
      get :new
      response.should_not be_success
    end
  end
  
  describe "Post 'Create'" do
    before(:each) do
      role = FactoryGirl.create(:role)
      @user.roles << role
      sign_in @user      
    end
    
    it "should be successful redirect after create" do
      post :create, :book => {:name => 'Create',:author_names => 'Create'}
      book = assigns(:book)
      flash[:notice].should_not be_nil    
      response.should be_redirect
      response.should redirect_to book_path(book)
    end

    it "should be successful redirect after save" do
      @attributes  = {:name => 'RoR',:author_names => 'David'}
      @book = mock_model(Book, @attributes)
      Book.stub!(:new).and_return(@book)      
      @book.should_receive(:save).and_return(true)
      post :create, :book => @attributes
      response.should redirect_to book_path(@book)      
    end
    
   it "should re-render action new after invalid save" do
      @attributes  = {:name => 'RoR',:author_names => 'David'}
      @book = mock_model(Book, @attributes)
      Book.stub!(:new).and_return(@book)      
      @book.should_receive(:save).and_return(false)
      post :create, :book => @attributes
      response.should render_template("new")
    end

   it "should re-render action new after invalid save" do
      @attributes  = {:name => 'RoR',:author_names => 'David'}
      @book = mock_model(Book, @attributes)
      Book.stub!(:new).and_return(@book)      
      @book.should_receive(:save).and_return(false)
      post :create, :book => @attributes
      response.should render_template("new")
    end

   it "should raise exception for already existing book" do
      @attributes  = {:name => 'RoR',:author_names => 'David'}
      @book = mock_model(Book, @attributes)
      Book.stub!(:new).and_return(@book)      
      @book.should_receive(:save).and_return(true)
      post :create, :book => @attributes
      @new_book = mock_model(Book, @attributes)
      Book.stub!(:new).and_return(@new_book)  
      @new_book.should_receive(:save).and_raise(InvalidBook)
      post :create, :book => @attributes
      response.should render_template("new")
    end

  end  
end
