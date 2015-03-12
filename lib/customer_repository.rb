require_relative 'customer'
require_relative 'customer_parser'

class CustomerRepository
  attr_reader :customers

  def initialize(data)
    parser = CustomerParser.new(data)
    @customers = parser.parse
  end

end
