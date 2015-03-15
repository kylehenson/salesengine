require_relative 'test_helper'
require_relative '../lib/transaction_parser'

class TransactionParserTest < Minitest::Test

  def test_it_exists
    assert TransactionParser
  end

  def test_it_can_read_the_file
    file_name = "./test/support/transactions.csv"
    parser = TransactionParser.new(file_name)
    refute_equal nil, parser.parse(nil)
  end

  def test_it_can_parse_a_csv_file
    file_name = "./test/support/transactions.csv"
    parser = TransactionParser.new(file_name)

    transactions = parser.parse(nil)
    first = transactions.first

    assert_equal Transaction, first.class
    assert_equal 1 ,first.id
  end
end
