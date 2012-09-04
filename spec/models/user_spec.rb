require 'spec_helper'

describe User do  
  it "should be in any role given" do
    role = FactoryGirl.create(:role)
    user = FactoryGirl.create(:user)
    user.roles << role
    user.should be_role("Admin User")
  end
end
