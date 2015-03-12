require_relative 'test_helper'
require_relative '../lib/item_parser'

class ItemParserTest < Minitest::Test

  def test_it_exists
    assert ItemParser
  end

  def test_it_can_read_the_file
    file_name = "./test/support/items.csv"
    parser = ItemParser.new(file_name)
    refute_equal nil, parser.parse
  end
  
  def test_it_can_parse_a_csv_file
    file_name = "./test/support/items.csv"
    parser = ItemParser.new(file_name)

    items = parser.parse
    first = items.first

    assert_equal Item, first.class
    assert_equal 1,first.id
  end
end
