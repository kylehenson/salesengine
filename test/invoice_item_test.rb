require_relative 'test_helper'
require_relative '../lib/invoice_item_parser'
require_relative '../lib/invoice_item'


class InvoiceItemTest < Minitest::Test

  def test_it_exists
    assert InvoiceItem
  end

  def test_invoice_has_invoice_id_and_id
    file = CSV.open("./support/invoice_items.csv", headers: true, header_converters: :symbol)
    first = file.first
    invoice_item = InvoiceItem.new(first)
    assert_equal 1, invoice_item.id
    assert_equal '1', invoice_item.invoice_id
  end

  def test_invoice_has_other_invoice_attributes
    file = CSV.open("./support/invoice_items.csv", headers: true, header_converters: :symbol)
    first = file.first
    invoice_item = InvoiceItem.new(first)
    assert_equal '539', invoice_item.item_id
    assert_equal '5', invoice_item.quantity
    assert_equal '13635', invoice_item.unit_price
  end

end
