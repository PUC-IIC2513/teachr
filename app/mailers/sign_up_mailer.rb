class SignUpMailer < ActionMailer::Base
  default from: "teachr@ing.puc.cl"
  
  def validate_email(user)
    @user = user
    # URL temporal, mientras tanto...
    @url = "http://localhost:3000/validate/#{user.id}/#{user.validation_hash}"
    mail to: user.email, subject: "Valida tu correo"
  end
end
