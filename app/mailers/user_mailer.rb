class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("sendMail.subject")
  end
  def password_reset user
    @user = user

    mail to: user.email, subject: t("forgotPassword.reset")
  end
end
