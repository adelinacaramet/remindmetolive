class ContactMailer < ApplicationMailer

  def contact(name, email, subject, message)
    @name = name
    @email  = email
    @message  = message
    mail(to: 'dan.persa@gmail.com', subject: subject)
  end
end
