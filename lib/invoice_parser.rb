require 'csv'
require_relative 'merchant'

class InvoiceParser
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def parse(parent)
    file = CSV.open(filename, headers: true, header_converters: :symbol)
    file.map do |line|
      Invoice.new(line, parent)
    end
  end

end
