class UserMailer < ActionMailer::Base
  default from: "Admin <godhuyang@gmail.com>"
  

  def follow_notification(current_user, followed_user)
    @user = current_user
    @followed_user = followed_user
    mail( to: "#{current_user.name} <#{current_user.email}>", subject: "Followed Notification" )
  end
end
