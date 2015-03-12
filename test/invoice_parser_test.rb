require_relative 'test_helper'
require_relative '../lib/invoice_parser'

class InvoiceParserTest < Minitest::Test

  def test_it_exists
    assert InvoiceParser
  end

  def test_it_can_read_the_file
    file_name = "./test/support/invoices.csv"
    parser = InvoiceParser.new(file_name)
    refute_equal nil, parser.filename
  end

  def test_it_can_parse_a_csv_file
    file_name = "./test/support/invoices.csv"
    parser = InvoiceParser.new(file_name)
    refute_equal nil, parser
    #ask someone how to test this
  end


end
