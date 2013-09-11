class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login

  protected
  def current_user
  	@current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  private
  def require_login
  	unless current_user
  		flash.alert = "You must sign in to see this content"
  		redirect_to new_session_path
  	end
  end
end
