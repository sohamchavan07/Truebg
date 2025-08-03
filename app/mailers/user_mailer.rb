class UserMailer < ApplicationMailer
  def welcome_email(user_email, user_name = nil)
    @user_name = user_name || "User"
    @user_email = user_email

    mail(
      to: user_email,
      subject: "Welcome to Truebg - Background Verification Initiated"
    )
  end
end
