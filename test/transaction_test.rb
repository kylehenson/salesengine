require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'
require_relative '../lib/transaction_repository'

class TransactionTest < Minitest::Test

  def test_it_exists
    assert Transaction
  end

  def test_transaction_has_id
    file = CSV.open("../test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first, nil)

    assert_equal 1, one_transaction.id
  end

  def test_transaction_has_invoice_id
    file = CSV.open("../test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first, nil)

    assert_equal 1, one_transaction.invoice_id
  end

  def test_transaction_has_credit_card_number
    file = CSV.open("../test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first, nil)

    assert_equal "4654405418249632", one_transaction.credit_card_number
  end

  def test_transaction_has_credit_card_expiration_date
    file = CSV.open("../test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first,nil)

    assert_equal nil, one_transaction.credit_card_expiration_date
  end

  def test_transaction_has_result
    file = CSV.open("../test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first,nil)

    assert_equal "success", one_transaction.result
  end

  def test_transaction_has_created_at
    file = CSV.open("../test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first,nil)

    assert_equal "2012-03-27 14:54:09 UTC", one_transaction.created_at
  end

  def test_transaction_has_updated_at
    file = CSV.open("../test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first,nil)

    assert_equal "2012-03-27 14:54:09 UTC", one_transaction.updated_at
  end

  class TransactionIntegrationTest < Minitest::Test
    attr_reader :engine, :transaction_repository, :invoice_repository

    def setup
      @engine = SalesEngine.new('../test/support/')
    end

    def test_it_can_receive_data_from_invoice_repo
      transaction = engine.transaction_repository.find_by_id(3)
      assert_equal "33", transaction.invoice.merchant_id
    end
  end
end
