require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    assert TransactionRepository
  end

  def test_it_holds_seven_transaction_instances
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert transaction_repo.transactions.count == 7
  end

  def test_it_contains_parsed_transaction_objects
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    first = transaction_repo.transactions.first
    assert_equal 1, first.invoice_id
  end

  def test_it_can_return_all_transactions
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    all = transaction_repo.all
    assert_equal 7, all.count
    assert_equal Transaction, all[0].class
  end

  def test_it_can_return_a_random_transaction
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    random = transaction_repo.random
    assert random
    assert_equal Transaction, random.class
  end

  def test_it_can_find_an_instance_of_transaction_by_id
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 4, transaction_repo.find_by_id(3).invoice_id
  end

  def test_it_can_find_an_instance_of_transaction_by_invoice_id
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 4, transaction_repo.find_by_invoice_id(5).id
  end

  def test_it_can_find_an_instance_of_transaction_by_credit_card_number
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 4, transaction_repo.find_by_credit_card_number("4515551623735607").id
  end

  def test_it_can_find_an_instance_of_transaction_by_credit_card_expiration_date
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 1, transaction_repo.find_by_credit_card_expiration_date(nil).id
  end

  def test_it_can_find_an_instance_of_transaction_by_result
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 1, transaction_repo.find_by_result("success").id
  end

  def test_it_can_find_an_instance_of_transaction_by_created_at
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 3, transaction_repo.find_by_created_at("2012-03-27 14:54:10 UTC").id
  end

  def test_it_can_find_an_instance_of_transaction_by_updated_at
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 3, transaction_repo.find_by_updated_at("2012-03-27 14:54:10 UTC").id
  end

  def test_it_can_find_all_instances_of_transaction_by_id
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 2, transaction_repo.find_all_by_id(1).count
  end

  def test_it_can_find_all_instances_of_transaction_by_invoice_id
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 2, transaction_repo.find_all_by_invoice_id(1).count
  end

  def test_it_can_find_all_instances_of_transaction_by_credit_card_number
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 1, transaction_repo.find_all_by_credit_card_number("4580251236515201").count
  end

  def test_it_can_find_all_instances_of_transaction_by_credit_card_expiration_date
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 7, transaction_repo.find_all_by_credit_card_expiration_date(nil).count
  end

  def test_it_can_find_all_instances_of_transaction_by_result
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 7, transaction_repo.find_all_by_result("success").count
  end

  def test_it_can_find_all_instances_of_transaction_by_created_at
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 3, transaction_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_can_find_all_instances_of_transaction_by_updated_at
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal 3, transaction_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_returns_an_empty_array_if_no_matches_for_find_all_by_x
    transaction_repo = TransactionRepository.new('./test/support/transactions.csv', nil)
    assert_equal [], transaction_repo.find_all_by_id(10)
  end
end
