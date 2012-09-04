class Role < ActiveRecord::Base
  #rolify gem's configuration are not used in this project. No need of resourses & stuff like that.
  #Code is been kept milimalistic.
  has_and_belongs_to_many :users, :join_table => :users_roles  
end
