# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'test1@test.com'
    password 'password'
  end
  
   factory :comment_user, :class => User do
    email 'test1@comment.com'
    password 'password'
  end

end
