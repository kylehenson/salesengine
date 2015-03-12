require 'csv'

class SalesEngine
  attr_accessor :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def startup
    filepath = "#{@filepath}/merchants.csv"
    @merchants = CSV.open(filepath,
                          headers: true,
                          header_converters: :symbol)
  end
end
