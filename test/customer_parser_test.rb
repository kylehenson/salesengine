require_relative 'test_helper'
require_relative '../lib/customer_parser'

class CustomerParserTest < Minitest::Test

  def test_it_exists
    assert CustomerParser
  end

  def test_it_can_read_the_file
    file_name = "./test/support/customers.csv"
    parser = CustomerParser.new(file_name)
    refute_equal nil, parser.parse
  end

  def test_it_can_parse_a_csv_file
    file_name = "./test/support/customers.csv"
    parser = CustomerParser.new(file_name)

    customers = parser.parse
    first = customers.first

    assert_equal Customer, first.class
    assert_equal 1 ,first.id
  end
end
