require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    assert CustomerRepository
  end

  def test_it_holds_six_customer_instances
    customer_repo = CustomerRepository.new('./test/support/customers.csv')
    assert customer_repo.customers.count == 6
  end

  def test_it_contains_parsed_customer_objects
    customer_repo = CustomerRepository.new('./test/support/customers.csv')
    first = customer_repo.customers.first
    assert_equal "Joey", first.first_name
  end

end
