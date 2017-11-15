class BookReservationExpireWorker
  include Sidekiq::Worker

  def perform(book_id)
    book = Book.find(book_id)

    BookMailer.book_return_remind(book).deliver
    BookMailer.book_reserved_return(book).deliver
  end
end