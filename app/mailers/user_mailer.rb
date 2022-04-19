class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("sendMail.subject")
  end
<<<<<<< HEAD
  def password_reset user
    @user = user

    mail to: user.email, subject: t("forgotPassword.reset")
  end
=======

>>>>>>> chapter-13
end
