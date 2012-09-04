class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user, :except => [:login, :logout]
  before_filter :authenticate_user!                                                     
                                                                 
  #This method is to avail the current_user in model.
  def set_current_user
    User.current_user = current_user
  end

  #This is to show the exceptions given by cancan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end