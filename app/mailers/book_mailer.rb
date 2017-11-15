class BookMailer < ApplicationMailer
  default from: 'warsztaty@infakt.pl'
  layout 'mailer'

  def take_notify(user, book)
    @user = user
    @book = book
    mail(to: user.email, subject: "Book titled '#{book.title}' take confirmation")
  end

  def book_return_remind(book)
    @book = book
    @reservation = book.reservations.find_by(status: 'TAKEN')

    @borrower = @reservation.user

    mail(to: @borrower.email, subject: "Upływa termin zwrotu książki #{book.title}")
  end

  def book_reserved_return(book)
    @book = book
    @reservation = book.reservations.find_by(status: 'TAKEN')

    @borrower = @reservation.user

    mail(to: @borrower.email, subject: "Książka, którą zarezerwowałeś #{book.title} będzie wkrótce dostępna ")
  end
end
