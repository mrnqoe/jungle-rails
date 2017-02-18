class ExampleMailer < ActionMailer::Base

  def sample_email(order)
    @order = order
    mail(to: 'mrnqoe@gmail.com', subject: 'Sample Email')
  end
end
