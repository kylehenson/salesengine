require_relative 'test_helper'
require_relative '../lib/merchant_parser'

class MerchantParserTest < Minitest::Test

  def test_it_exists
    assert MerchantParser
  end

  def test_it_can_read_the_file
    file_name = "./test/support/merchants.csv"
    parser = MerchantParser.new(file_name)
    refute_equal nil, parser.filename
  end

  def test_it_can_parse_a_csv_file
    file_name = "./test/support/merchants.csv"
    parser = MerchantParser.new(file_name)
    refute_equal nil, parser
    #ask someone how to test this
  end


end
