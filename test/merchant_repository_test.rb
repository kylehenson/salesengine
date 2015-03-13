require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    assert MerchantRepository
  end

  def test_it_holds_seven_merchant_instances
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert merchant_repo.merchants.count == 7
  end

  def test_it_contains_parsed_merchant_objects
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    first = merchant_repo.merchants.first
    assert_equal "Schroeder-Jerde", first.name
  end

  def test_it_can_return_all_merchants
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    all = merchant_repo.all
    assert_equal 7, all.count
    assert_equal Merchant, all[0].class
  end

  def test_it_can_return_a_random_merchant
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    random =  merchant_repo.random
    assert random
    assert_equal Merchant, random.class
  end

  def test_it_can_find_an_instance_of_merchant_by_id
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal "Willms and Sons", merchant_repo.find_by_id(3).name
  end

  def test_it_can_find_an_instance_of_merchant_by_name
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal 2, merchant_repo.find_by_name("Klein, Rempel and Jones").id
  end

  def test_it_can_find_an_instance_of_merchant_by_created_at
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal 1, merchant_repo.find_by_created_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_an_instance_of_merchant_by_updated_at
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal 1, merchant_repo.find_by_updated_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_all_instances_of_merchant_by_id
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal 2, merchant_repo.find_all_by_id(1).count
  end

  def test_it_can_find_all_instances_of_merchant_by_name
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal 2, merchant_repo.find_all_by_name("Williamson Group").count
  end

  def test_it_can_find_all_instances_of_merchant_by_created_at
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal 7, merchant_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_can_find_all_instances_of_merchant_by_updated_at
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal 6, merchant_repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_returns_an_empty_array_if_no_matches_for_find_all_by_x
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv')
    assert_equal [], merchant_repo.find_all_by_id(10)
  end

end
