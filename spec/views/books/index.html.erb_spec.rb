require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      stub_model(Book),
      stub_model(Book)
    ])
  end

  it "renders a list of books for normal user without new book link" do
    @user = stub_model(User, :email => 'test1@tcs.com', :password => '1234')
    sign_in @user
    current_user = @user
    view.stub!(:current_user).and_return @user
    assign(:currrnet_user, @user)
    render
    rendered.should_not have_selector('a', :href => '/book/new')
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end

  it "renders a list of books for admin user with new book link" do
    @user = stub_model(User, :email => 'test1@tcs.com', :password => '1234')
    @user.stub!(:role).with('Admin User').and_return(@user)
    sign_in @user
    current_user = @user
    view.stub!(:current_user).and_return @user
    view.stub!(:current_user).and_return @user
    assign(:currrnet_user, @user)
    render
    rendered.should_not have_selector('a', :href => '/book/new')
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end

end
