require 'spec_helper'

describe "Books" do
  describe "GET /books" do
    it "works!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get books_path
      #User is not signed in so redirect to login page
      response.status.should == 302
    end
  end
end
