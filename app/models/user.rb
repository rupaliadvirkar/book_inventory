class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  #Add HABTM to roles
  has_and_belongs_to_many :roles, :join_table => :users_roles
  
  #Add comments assosiation
  has_many :comments
  
  #This method authenticate user against its role
  def role?(role)
    return !!self.roles.find_by_name(role)
  end
  
   #This to avail the current_user in model. Thread safe is just to avoid overriding.
   class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end
end
