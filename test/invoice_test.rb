require_relative 'test_helper'
require_relative '../lib/invoice_parser'
require_relative '../lib/invoice'


class InvoiceTest < Minitest::Test

  def test_it_exists
    assert Invoice
  end

  def test_invoice_has_customer_id_and_id
    file = CSV.open("./test/support/invoices.csv", headers: true, header_converters: :symbol)
    first = file.first
    invoice = Invoice.new(first)
    assert_equal 1, invoice.id
    assert_equal "1", invoice.customer_id
  end

  def test_invoice_has_other_invoice_attributes
    file = CSV.open("./test/support/invoices.csv", headers: true, header_converters: :symbol)
    first = file.first
    invoice = Invoice.new(first)
    assert_equal 'shipped', invoice.status
    assert_equal '26', invoice.merchant_id
  end

end
