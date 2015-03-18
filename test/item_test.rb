require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    assert Item
  end

  def test_item_has_id
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first, nil)

    assert_equal 1, one_item.id
  end

  def test_item_has_name
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first, nil)

    assert_equal "Item Qui Esse", one_item.name
  end

  def test_item_has_a_description
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first, nil)

    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", one_item.description
  end

  def test_item_has_a_unit_price
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first, nil)

    assert "75107", one_item.unit_price
  end

  def test_item_has_a_merchant_id
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first, nil)

    assert_equal 1, one_item.merchant_id
  end

  def test_item_has_a_created_at
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first, nil)

    assert_equal "2012-03-27 14:53:59 UTC", one_item.created_at
  end

  def test_item_has_a_updated_at
    file = CSV.open("./test/support/items.csv", headers: true, header_converters: :symbol)
    first = file.first
    one_item = Item.new(first,nil)

    assert_equal "2012-03-27 14:53:59 UTC", one_item.updated_at
  end

  class ItemIntegrationTest < Minitest::Test
    attr_reader :engine, :item_repository, :merchant_repository

    def setup
      @engine = SalesEngine.new('./test/support/')
    end

    def test_it_can_receive_data_from_merchant_repo
      item = engine.item_repository.items.first
      assert_equal Merchant, item.merchant.class
    end

    def test_it_can_receive_data_from_invoice_items_repo
      item = engine.item_repository.items[1]
      assert_equal InvoiceItem, item.invoice_items[0].class
    end

    def test_it_can_get_quantity_and_invoice_id_from_invoice_items
      engine = SalesEngine.new('./data')
      item = engine.item_repository.items[0]
      assert_equal Date, item.best_day.class
      assert_equal Date.parse("2012-03-15"), item.best_day
    end

    def test_it_can_retrieve_total_revenue_for_given_item
      item = engine.item_repository.items[1]
      assert_equal 285572, item.total_item_revenue.to_i
    end

    def test_it_can_retrieve_successful_invoice_items
      engine = SalesEngine.new('./data')
      item = engine.item_repository.items[0]
      refute_equal item.invoice_items, item.successful_invoice_items
    end
  end
end
