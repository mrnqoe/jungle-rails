class UserMailer < ApplicationMailer
  default from: 'mrnqo404@gmail.com'

  layout "mailer"

  def user_mailer(user)
    @user = user
    mail(
    to:            'niqla@me.com',
    subject:       "Welcome to My Awesome Site",
    sent_on:       Time.now,
    body:          'HEY MAN INSIDE',
    content_type:  "text/html")
  end
end
