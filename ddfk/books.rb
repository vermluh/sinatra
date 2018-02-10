# encoding: UTF-8

class Books
  def self.all
    if @books.nil? then
      @books = []
      books_from_file = []
      CSV.foreach('./data/ddfk.csv', { :col_sep => "\t", :headers => true }).each do |row|
        books_from_file << Book.new(row)
      end
      books_from_file.group_by { |book| book.number[/\D+/] }
                     .sort_by { |key, books| key ||= '' }
                     .each do |key, books|
                       @books << books.sort do |x,y|
                         comp = (x.number[/\d+/].to_i <=> y.number[/\d+/].to_i)
                         comp.zero? ? (x.title <=> y.title) : comp
                       end
                     end
      @books.flatten!
    end
    @books
  end
end