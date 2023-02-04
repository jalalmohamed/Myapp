class UserMailer < ApplicationMailer

  def welcome(user)
    @user=user
    @url='http://127.0.0.1:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to our site!')
  end
end
