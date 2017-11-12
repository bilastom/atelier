require "rails_helper"

describe 'book routes', type: :routing do
  it 'routes to root' do
    expect(get: '/').to route_to('books#index')
  end

  it 'routes to the google_books' do
    expect(get: '/google-isbn').to route_to('google_books#show')
  end

  it 'routes to book reserve' do
    expect(get: '/books/1/reserve').to route_to('reservations#reserve', book_id: '1')
  end

  it 'routes to book take' do
    expect(get: '/books/1/take').to route_to('reservations#take', book_id: '1')
  end

  it 'routes to book give_back' do
    expect(get: '/books/1/give_back').to route_to('reservations#give_back', book_id: '1')
  end

  it 'routes to book reservations cancel' do
    expect(get: '/books/1/give_back').to route_to('reservations#give_back', book_id: '1')
  end

  it 'routes to book reservations list of user' do
    expect(get: '/users/1/reservations').to route_to('reservations#users_reservations', user_id: '1')
  end

  it 'routes to book index' do
    expect(get: '/books').to route_to('books#index')
  end

  it 'routes to create book' do
    expect(post: '/books').to route_to('books#create')
  end

  it 'routes to new book' do
    expect(get: '/books/new').to route_to('books#new')
  end

  it 'routes to book edit' do
    expect(get: '/books/1/edit').to route_to('books#edit', id: '1')
  end

  it 'routes to book show' do
    expect(get: '/books/1').to route_to('books#show', id: '1')
  end

  it 'routes to book update' do
    expect(patch: '/books/1').to route_to('books#update', id: '1')
  end

  it 'routes to book update' do
    expect(put: '/books/1').to route_to('books#update', id: '1')
  end

  it 'routes to book delete' do
    expect(delete: '/books/1').to route_to('books#destroy', id: '1')
  end
end
