require 'csv'
require_relative 'item'

class ItemParser
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def parse(parent)
    file = CSV.open(filename, headers: true, header_converters: :symbol)
    file.map do |line|
      Item.new(line, parent)
    end
  end

end
