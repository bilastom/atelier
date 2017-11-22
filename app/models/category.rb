class Category < ActiveYaml::Base
  # has_many :books
  set_root_path 'db/data'

  def books(adult = false) # if true user is adult
    books = ::Book.where(category_id: self.id)

    filter_adult_books(books) unless adult
  end

  def similar_books(adult = false)
    books = Book.where(category_id: similar_ids)
    filter_adult_books(books) unless adult
  end

  private

  def filter_adult_books(books)
    books.where(category_id: not_adult_category_ids)
  end

  def not_adult_category_ids
    Category.where(adult: false).pluck(:id)
  end

  def similar_ids
    similar_categories.map { |name| Category.find_by(name: name).id }
  end


end
