# encoding: UTF-8

class Books
  def self.all
    if @books.nil? then
      @books = []
      CSV.foreach('./data/ddfk.csv', { :col_sep => "\t", :headers => true }).each do |row|
        @books << Book.new(row)
      end
    end
    @books
  end
end