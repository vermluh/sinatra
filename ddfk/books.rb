# rubocop:disable Metrics/LineLength

class Books
  def self.read_and_sort_books_from_file
    books_from_file = []
    CSV.foreach('./data/ddfk.csv', col_sep: "\t", headers: true).each do |row|
      books_from_file << Book.new(row)
    end
    books_from_file
  end

  def self.group_and_sort_books(books)
    books.sort_by { |book| book.number[/\D+/] || '' }
         .group_by { |book| book.number[/\D+/] }
  end

  def self.all
    if @books.nil?
      @books = []
      books_from_file = read_and_sort_books_from_file
      grouped_books = group_and_sort_books(books_from_file)
      grouped_books.each_value { |books| @books << books.sort }
      @books.flatten!
    end
    @books
  end
end

# rubocop:enable Metrics/LineLength