class ExampleMailer < ActionMailer::Base

  def sample_email(user)
    @user = user
    mail(to: 'mrnqoe@gmail.com', subject: 'Sample Email')
  end
end
