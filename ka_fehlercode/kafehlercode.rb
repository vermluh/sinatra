# encoding: UTF-8

DB = Sequel.sqlite
DB.create_table :ka_fehlercode do
  Integer :kaf_nummer, :primary_key => true
  String :kaf_text
end

class KaFehlercode < Sequel::Model(:ka_fehlercode)
  set_primary_key [:kaf_nummer]
  
  def to_json(*a)
    {
      "id"     => kaf_nummer.to_i,
      "text" => kaf_text.encode('UTF-8')
    }.to_json(*a)
  end
end

CSV.foreach('./error_codes.csv', :col_sep => "\t") do |entry|
  KaFehlercode.insert(:kaf_nummer => entry[0].to_i, :kaf_text => entry[1])
end