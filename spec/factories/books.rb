# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    name 'The Magic of thinking big'
    author_names 'David J. Schwartz'
  end
  
  factory :new_book, :class => Book do
    name 'The Magic of thinking big'
    author_names 'David J. Schwartz, Schwartz'
  end
end
