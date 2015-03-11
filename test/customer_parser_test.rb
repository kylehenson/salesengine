require_relative 'test_helper'
require_relative '../lib/customer_parser'

class CustomerParserTest < Minitest::Test

  def test_it_exists
    assert CustomerParser
  end

  def test_it_can_read_the_file
    file_name = "./test/support/customers.csv"
    parser = CustomerParser.new(file_name)
    refute_equal nil, parser.customers
  end

  def test_it_can_parse_a_csv_file
    file_name = "./test/support/customers.csv"
    parser = CustomerParser.new(file_name)

    customers = parser.parse
    first = customers.first

    assert_equal Customer, first.class
    assert_equal "1" ,first.id
  end

  def test_customer_has_customer_attributes
    file_name = "./test/support/customers.csv"
    parser = CustomerParser.new(file_name)

    customers = parser.parse
    first = customers.first
    assert_equal "1", first.id
    assert_equal "Joey", first.first_name
    assert_equal "Ondricka", first.last_name
  end

  def test_customer_has_customer_attributes
    file_name = "./test/support/customers.csv"
    parser = CustomerParser.new(file_name)

    customers = parser.parse
    first = customers.last
    assert_equal "6", first.id
    assert_equal "Heber", first.first_name
    assert_equal "Kuhn", first.last_name
  end

end
