class ReservationsHandler
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def reserve(book)
    return unless book.can_be_reserved?(user)

    book.reservations.create(user: user, status: 'RESERVED')
  end

  def take(book)
    return unless book.can_be_taken? user

    if book.available_reservation.present?
      perform_expiration_worker(book.available_reservation)
      book.available_reservation.update_attributes(status: 'TAKEN')
    else
      reservation = book.reservations.create(user: user, status: 'TAKEN')
      # BookMailer.take_notify(user, book).deliver_now if reservation.save
      perform_expiration_worker(reservation)
    end
  end

  def give_back(book)
    ActiveRecord::Base.transaction do
      book.reservations.find_by(status: 'TAKEN').update_attributes(status: 'RETURNED')
      book.next_in_queue.update_attributes(status: 'AVAILABLE') if next_in_queue(book).present?
    end
  end

  def cancel_reservation(book)
    book.reservations.where(user: user, status: 'RESERVED').order(created_at: :asc).first.update_attributes(status: 'CANCELED')
  end

  private

  def next_in_queue(book)
    book.reservations.where(status: 'RESERVED').order(created_at: :asc).first
  end

  def perform_expiration_worker(res)
    ::BookReservationExpireWorker.perform_at(res.expires_at - 1.day, res.book.id)
  end
end
