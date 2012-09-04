# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    comment 'This is book is very nice.'
  end
  
  factory :author_comment, :class => Comment do
    comment 'This is author is very nice.'
  end

end
