require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    assert MerchantRepository
  end

  def test_it_holds_seven_merchant_instances
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert merchant_repo.merchants.count == 7
  end

  def test_it_contains_parsed_merchant_objects
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    first = merchant_repo.merchants.first
    assert_equal "Schroeder-Jerde", first.name
  end

  def test_it_can_return_all_merchants
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    all = merchant_repo.all
    assert_equal 7, all.count
    assert_equal Merchant, all[0].class
  end

  def test_it_can_return_a_random_merchant
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    random =  merchant_repo.random
    assert random
    assert_equal Merchant, random.class
  end

  def test_it_can_find_an_instance_of_merchant_by_id
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal "Willms and Sons", merchant_repo.find_by_id(3).name
  end

  def test_it_can_find_an_instance_of_merchant_by_name
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal 2, merchant_repo.find_by_name("Klein, Rempel and Jones").id
  end

  def test_it_can_find_an_instance_of_merchant_by_created_at
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal 1, merchant_repo.find_by_created_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_an_instance_of_merchant_by_updated_at
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal 1, merchant_repo.find_by_updated_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_all_instances_of_merchant_by_id
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal 2, merchant_repo.find_all_by_id(1).count
  end

  def test_it_can_find_all_instances_of_merchant_by_name
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal 2, merchant_repo.find_all_by_name("Williamson Group").count
  end

  def test_it_can_find_all_instances_of_merchant_by_created_at
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal 7, merchant_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_can_find_all_instances_of_merchant_by_updated_at
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal 6, merchant_repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_returns_an_empty_array_if_no_matches_for_find_all_by_x
    merchant_repo = MerchantRepository.new('./test/support/merchants.csv', nil)
    assert_equal [], merchant_repo.find_all_by_id(10)
  end

  def test_it_can_return_all_revenues_for_given_date
    skip
    engine = SalesEngine.new('./data')
    assert_equal BigDecimal, engine.merchant_repository.revenue("2012-03-17").class
  end

  def test_it_can_return_the_merchant_with_the_most_revenue
    engine = SalesEngine.new('./test/support')
    merch_repo = engine.merchant_repository
    assert_equal Array, merch_repo.most_revenue(1).class
    assert_equal 1, merch_repo.most_revenue(1).count
    assert_equal 'Schroeder-Jerde', merch_repo.most_revenue(1).first.name
  end

  def test_it_can_return_multiple_merchants_with_top_revenue
    engine = SalesEngine.new('./test/support')
    merch_repo = engine.merchant_repository
    assert_equal 2, merch_repo.most_revenue(2).count
    assert_equal 'Williamson Group', merch_repo.most_revenue(2).last.name
  end

end
