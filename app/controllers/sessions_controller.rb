class SessionsController < ApplicationController
  skip_before_filter :require_login
  
  def new
  end

  def create  	
  	if u = User.authenticate(params[:session][:email], params[:session][:password])
  		session[:user_id] = u.id
  		redirect_to root_path
  	else
  		flash.now.alert = "Wrong email or password."
  		render :new
  	end
  end

  def destroy
  end
end
