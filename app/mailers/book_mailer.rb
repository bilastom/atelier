class BookMailer < ApplicationMailer
  default from: 'warsztaty@infakt.pl'
  layout 'mailer'

  def take_notify(user, book)
    @user = user
    @book = book
    mail(to: user.email, subject: "Book titled '#{book.title}' take confirmation")
  end
end
