require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def test_it_exists
    assert Transaction
  end

  def test_transaction_has_id
    file = CSV.open("./test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first)

    assert_equal 1, one_transaction.id
  end

  def test_transaction_has_invoice_id
    file = CSV.open("./test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first)

    assert_equal 1, one_transaction.invoice_id
  end

  def test_transaction_has_credit_card_number
    file = CSV.open("./test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first)

    assert_equal "4654405418249632", one_transaction.credit_card_number
  end

  def test_transaction_has_credit_card_expiration_date
    file = CSV.open("./test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first)

    assert_equal nil, one_transaction.credit_card_expiration_date
  end

  def test_transaction_has_result
    file = CSV.open("./test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first)

    assert_equal "success", one_transaction.result
  end

  def test_transaction_has_created_at
    file = CSV.open("./test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first)

    assert_equal "2012-03-27 14:54:09 UTC", one_transaction.created_at
  end

  def test_transaction_has_updated_at
    file = CSV.open("./test/support/transactions.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_transaction = Transaction.new(first)

    assert_equal "2012-03-27 14:54:09 UTC", one_transaction.updated_at
  end

end
