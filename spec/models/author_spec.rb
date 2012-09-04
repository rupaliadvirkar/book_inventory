require 'spec_helper'

describe Author do
 it "should add given author comment" do
   author = FactoryGirl.create(:author)
   comment = FactoryGirl.create(:author_comment, :commentable => author)
   comment.commentable_id.should == author.id
   comment.commentable_type.to_s.should == 'Author'
 end
end
