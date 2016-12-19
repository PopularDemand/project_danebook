class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Awesome')
  end

  def comment_notification(receiver, sender, comment)
    @sender = sender
    @receiver = receiver
    unless @sender == @receiver
      @comment = comment
      mail(to: @receiver.email, subject: "New comment from #{@sender.full_name}")
    end
  end

end
