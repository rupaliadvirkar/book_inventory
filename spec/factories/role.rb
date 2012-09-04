# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    name 'Admin User'
  end
  
  factory :normal_user, :class => Role do
    name 'Normal User'
  end
end
