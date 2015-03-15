require_relative 'test_helper'
require_relative '../lib/invoice_item_parser'
require_relative '../lib/invoice_item'


class InvoiceItemTest < Minitest::Test

  def test_it_exists
    assert InvoiceItem
  end

  def test_invoice_has_invoice_id_and_id
    file = CSV.open("./test/support/invoice_items.csv", headers: true, header_converters: :symbol)
    first = file.first
    invoice_item = InvoiceItem.new(first, nil)
    assert_equal 1, invoice_item.id
    assert_equal 1, invoice_item.invoice_id
  end

  def test_invoice_has_other_invoice_attributes
    file = CSV.open("./test/support/invoice_items.csv", headers: true, header_converters: :symbol)
    first = file.first
    invoice_item = InvoiceItem.new(first, nil)
    assert_equal 539, invoice_item.item_id
    assert_equal '5', invoice_item.quantity
    assert_equal '13635', invoice_item.unit_price
  end

  class InvoiceItemIntegrationTest < Minitest::Test
    attr_reader :engine

    def setup
      @engine = SalesEngine.new('./test/support')
    end

    def test_it_can_receive_data_from_item_repo
      invoice_item = engine.invoice_item_repository.invoice_items[0]
      assert_equal Item, invoice_item.item.class
    end

    def test_it_can_receive_data_from_invoice_repo
      invoice_item = engine.invoice_item_repository.invoice_items[0]
      assert_equal Invoice, invoice_item.invoice.class
    end
  end
end
