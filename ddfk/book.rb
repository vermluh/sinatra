# encoding: UTF-8

class Book
  attr_accessor :number, :title
  
  def initialize(row)
    @number = row['Nummer'] ||= 'unbekannt'
    @title = row['Titel']
  end
  
  def to_json(*a)
    {
      "number"     => @number,
      "title" => @title.encode('UTF-8')
    }.to_json(*a)
  end
end