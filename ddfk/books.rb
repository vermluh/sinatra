# encoding: UTF-8

class Books
  def self.all
    if @books.nil? then
      @books = []
      books_from_file = []
      CSV.foreach('./data/ddfk.csv', { :col_sep => "\t", :headers => true }).each do |row|
        books_from_file << Book.new(row)
      end
      grouped_books = books_from_file.group_by { |book| book.number[/\D+/] }
      grouped_books.keys.sort_by { |key| key ||= '' }.each do |key|
        @books << grouped_books[key]
                    .sort do |x,y|
                      comp = (x.number.to_i <=> y.number.to_i)
                      comp.zero? ? (x.title <=> y.title) : comp
                    end
      end
      @books.flatten!
    end
    @books
  end
end