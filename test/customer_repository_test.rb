require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    assert CustomerRepository
  end

  def test_it_holds_seven_customer_instances
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert customer_repo.customers.count == 7
  end

  def test_it_contains_parsed_customer_objects
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    first = customer_repo.customers.first
    assert_equal "Joey", first.first_name
  end

  def test_it_can_return_all_customers
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    all = customer_repo.all
    assert_equal 7, all.count
    assert_equal Customer, all[0].class
  end

  def test_it_can_return_a_random_customer
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    random =  customer_repo.random
    assert random
    assert_equal Customer, random.class
  end

  def test_it_can_find_an_instance_of_customer_by_id
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal "Mariah", customer_repo.find_by_id(3).first_name
  end

  def test_it_can_find_an_instance_of_customer_by_first_name
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 2, customer_repo.find_by_first_name("Cecelia").id
  end

  def test_it_can_find_an_instance_of_customer_by_last_name
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 3, customer_repo.find_by_last_name("Toy").id
  end

  def test_it_can_find_an_instance_of_customer_by_created_at
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 2, customer_repo.find_by_created_at("2012-03-27 14:54:10 UTC").id
  end

  def test_it_can_find_an_instance_of_customer_by_updated_at
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 2, customer_repo.find_by_updated_at("2012-03-27 14:54:10 UTC").id
  end

  def test_it_can_find_all_instances_of_customer_by_id
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 2, customer_repo.find_all_by_id(1).count
  end

  def test_it_can_find_all_instances_of_customer_by_first_name
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 2, customer_repo.find_all_by_first_name("Joey").count
  end

  def test_it_can_find_all_instances_of_customer_by_last_name
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 2, customer_repo.find_all_by_last_name("Ondricka").count
  end

  def test_it_can_find_all_instances_of_customer_by_created_at
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 2, customer_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_can_find_all_instances_of_customer_by_updated_at
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)
    assert_equal 2, customer_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_returns_an_empty_array_if_no_matches_for_find_all_by_x
    customer_repo = CustomerRepository.new('./test/support/customers.csv', nil)    
    assert_equal [], customer_repo.find_all_by_id(10)
  end

end
