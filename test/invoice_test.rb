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
    invoice = Invoice.new(first, nil)
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
  end

  def test_invoice_has_other_invoice_attributes
    file = CSV.open("./test/support/invoices.csv", headers: true, header_converters: :symbol)
    first = file.first
    invoice = Invoice.new(first, nil)
    assert_equal 'shipped', invoice.status
    assert_equal 26, invoice.merchant_id
  end

  class InvoiceIntegrationTest < Minitest::Test
    attr_reader :engine

    def setup
      @engine = SalesEngine.new('./test/support/')
    end

    def test_it_can_receive_data_from_customer_repo
      invoice = engine.invoice_repository.invoices[0]
      assert_equal Customer, invoice.customer.class
    end

    def test_it_can_receive_data_from_merchant_repo
      invoice = engine.invoice_repository.invoices[3]
      assert_equal Merchant, invoice.merchant.class
    end

    def test_it_can_receive_data_from_invoice_items
      invoice = engine.invoice_repository.invoices[0]
      assert_equal InvoiceItem, invoice.invoice_items[0].class
    end

    def test_it_can_receive_data_from_transactions
      invoice = engine.invoice_repository.invoices[0]
      assert_equal Transaction, invoice.transactions[0].class
    end

    def test_it_can_receive_data_from_items_via_invoice_items
      invoice = engine.invoice_repository.invoices[0]
      assert_equal Item, invoice.items[0].class
    end

  end
end
