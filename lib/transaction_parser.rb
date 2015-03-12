require 'csv'
require_relative 'transaction'

class TransactionParser
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def parse
    file = CSV.open(filename, headers: true, header_converters: :symbol)
    file.map do |line|
      Transaction.new(line)
    end
  end

end
