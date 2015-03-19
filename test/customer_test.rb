require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :file

  def setup
    @file = ("./test/support/customers.csv")
  end

  def test_it_exists
    assert Customer
  end

  def test_customer_has_id
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first, nil)

    assert_equal 1, one_customer.id
  end

  def test_customer_has_first_name
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first, nil)

    assert_equal "Joey", one_customer.first_name
  end

  def test_customer_has_last_name
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first, nil)

    assert_equal "Ondricka", one_customer.last_name
  end

  def test_customer_has_created_at
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first, nil)

    assert_equal "2012-03-27 14:54:09 UTC", one_customer.created_at
  end

  def test_customer_has_updated_at
    file = CSV.open("./test/support/customers.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_customer = Customer.new(first, nil)

    assert_equal "2012-03-27 14:54:09 UTC", one_customer.updated_at
  end

class CustomerIntegrationTest < Minitest::Test
  attr_reader :engine, :customer_repository, :invoice_repository

  def setup
    @engine = SalesEngine.new('./test/support/')
  end

  def test_it_can_receive_data_from_invoice_repo
    customers = engine.customer_repository.invoices(1)
    assert_equal 7, customers.count
  end

  def test_it_can_receive_transactions_for_a_customer
    engine = SalesEngine.new('./data')
    customer = engine.customer_repository.customers.first
    assert_equal Array, customer.transactions.class
    refute customer.transactions.empty?
  end

  def favorite_merchant
    customer = engine.customer_repository.customers[0]
    assert Merchant, customer.favorite_merchant.class
  end

  def test_successful_invoices
    customer = engine.customer_repository.customers[0]
    assert_equal Array, customer.successful_invoices.class
    refute customer.successful_invoices.any? { |invoice| invoice.success? == false }
  end
end
end
