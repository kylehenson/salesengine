require 'csv'
require_relative 'customer'

class CustomerParser
  attr_reader :customers

  def initialize(customers)
    @customers = CSV.read(customers, headers: true)
  end

  def parse
    @customers.map do |customer|
      id         = customer[0]
      first_name = customer[1]
      last_name  = customer[2]
      created_at = customer[3]
      updated_at = customer[4]
      Customer.new(id, first_name, last_name, created_at, updated_at)
    end
  end

end
