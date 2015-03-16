require_relative 'test_helper'
require_relative '../lib/invoice_item_parser'

class InvoiceItemParserTest < Minitest::Test

  def test_it_exists
    assert InvoiceItemParser
  end

  def test_it_can_read_the_file
    file_name = "./test/support/invoice_items.csv"
    parser = InvoiceItemParser.new(file_name)
    refute_equal nil, parser.parse(nil)
  end

  def test_it_can_parse_a_csv_file
    file_name = "./test/support/invoice_items.csv"
    parser = InvoiceItemParser.new(file_name)
    refute_equal nil, parser.parse(nil)
  end


end
