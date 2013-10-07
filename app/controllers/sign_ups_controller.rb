class SignUpsController < ApplicationController
  skip_before_filter :require_login
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      # antes de redireccionar, enviaremos el correo de validación de e-mail
      SignUpMailer.validate_email(@user).deliver
      redirect_to new_session_path, notice: 'Te registraste exitosamente.'
    else
      render action: 'new'
    end
  end
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  
end
