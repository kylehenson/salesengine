require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_it_exists
    assert Customer
  end

  def test_customer_has_id
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first)

    assert_equal 1, one_customer.id
  end

  def test_customer_has_first_name
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first)

    assert_equal "Joey", one_customer.first_name
  end

  def test_customer_has_last_name
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first)

    assert_equal "Ondricka", one_customer.last_name
  end

  def test_customer_has_created_at
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first)

    assert_equal "2012-03-27 14:54:09 UTC", one_customer.created_at
  end

  def test_customer_has_updated_at
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first)

    assert_equal "2012-03-27 14:54:09 UTC", one_customer.updated_at
  end
end
