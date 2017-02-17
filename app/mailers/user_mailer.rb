class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  layout "mailer"

  def user_mailer(order)
    @order = order
    mail(
    to:            'niqla@me.com',
    subject:       "Welcome to My Awesome Site",
    sent_on:       Time.now,
    body:          'HEY MAN INSIDE',
    content_type:  "text/html")
  end
end
