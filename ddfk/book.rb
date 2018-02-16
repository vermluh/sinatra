# rubocop:disable Metrics/LineLength

class Book
  include Comparable
  attr_accessor :number, :title

  def initialize(row)
    @number = row['Nummer'] ||= 'unbekannt'
    @title = row['Titel']
  end

  def to_json(*a)
    {
      number: @number,
      title: @title.encode('UTF-8')
    }.to_json(*a)
  end

  def numeric_number_part
    @number[/\d+/].to_i
  end

  def <=>(other)
    if numeric_number_part == other.numeric_number_part
      @title <=> other.title
    else
      numeric_number_part <=> other.numeric_number_part
    end
  end
end

# rubocop:enable Metrics/LineLength