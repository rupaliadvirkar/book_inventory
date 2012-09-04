require 'spec_helper'

describe "books/show" do
  before(:each) do
    @book = assign(:book, stub_model(Book))
    @authors = assign(:authors, [stub_model(Author)])
    @user = stub_model(User, :email => 'test1@tcs.com', :password => '1234')
    @comment = stub_model(Comment, :comment => 'Hi', :commentable => @book, :user => @user, :created_at => Time.now)
    @comments = assign(:comments, [@comment])
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
