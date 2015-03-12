require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    assert Item
  end

  def test_item_has_id
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first)

    assert_equal 1, one_item.id
  end

  def test_item_has_name
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first)

    assert_equal "Item Qui Esse", one_item.name
  end

  def test_item_has_a_description
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first)

    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", one_item.description
  end

  def test_item_has_a_unit_price
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first)

    assert_equal "75107", one_item.unit_price
  end

  def test_item_has_a_merchant_id
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first)

    assert_equal "1", one_item.merchant_id
  end

  def test_item_has_a_created_at
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first)

    assert_equal "2012-03-27 14:53:59 UTC", one_item.created_at
  end

  def test_item_has_a_updated_at
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first)

    assert_equal "2012-03-27 14:53:59 UTC", one_item.updated_at
  end

end
