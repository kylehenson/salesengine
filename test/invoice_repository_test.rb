require 'date'
require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    assert InvoiceRepository
  end

  def test_it_holds_seven_invoice_instances
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert invoice_repo.invoices.count == 7
  end

  def test_it_contains_parsed_invoice_objects
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    first = invoice_repo.invoices.first
    assert_equal 1, first.customer_id
  end

  def test_it_can_return_all_invoices
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    all = invoice_repo.all
    assert_equal 7, all.count
    assert_equal Invoice, all[0].class
  end

  def test_it_can_return_a_random_invoice
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    random = invoice_repo.random
    assert random
    assert_equal Invoice, random.class
  end

  def test_it_can_find_an_instance_of_invoice_by_id
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 75, invoice_repo.find_by_id(2).merchant_id
  end

  def test_it_can_find_an_instance_of_invoice_by_customer_id
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 26, invoice_repo.find_by_customer_id(1).merchant_id
  end

  def test_it_can_find_an_instance_of_invoice_by_merchant_id
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 2, invoice_repo.find_by_merchant_id(75).id
  end

  def test_it_can_find_an_instance_of_invoice_by_status
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 1, invoice_repo.find_by_status("shipped").id
  end

  def test_it_can_find_an_instance_of_invoice_by_created_at
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal Fixnum, invoice_repo.find_by_created_at(Date.parse("2012-03-24 15:54:10 UTC")).id.class
  end

  def test_it_can_find_an_instance_of_invoice_by_updated_at
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 4, invoice_repo.find_by_updated_at("2012-03-24 15:54:10 UTC").id
  end

  def test_it_can_find_all_instances_of_invoice_by_id
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 2, invoice_repo.find_all_by_id(1).count
  end

  def test_it_can_find_all_instances_of_invoice_by_customer_id
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 7, invoice_repo.find_all_by_customer_id(1).count
  end

  def test_it_can_find_all_instances_of_invoice_by_merchant_id
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 1, invoice_repo.find_all_by_merchant_id(75).count
  end

  def test_it_can_find_all_instances_of_invoice_by_status
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 7, invoice_repo.find_all_by_status("shipped").count
  end

  def test_it_can_find_all_instances_of_invoice_by_created_at
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert 1, invoice_repo.find_all_by_created_at("2012-03-24").count
  end

  def test_it_can_find_all_instances_of_invoice_by_updated_at
    invoice_repo = InvoiceRepository.new('./test/support/invoices.csv', nil)
    assert_equal 1, invoice_repo.find_all_by_updated_at("2012-03-24 15:54:10 UTC").count
  end

  def test_it_returns_an_empty_array_if_no_matches_for_find_all_by_x
    invoice_repo = InvoiceRepository.new('./test/support/customers.csv', nil)
    assert_equal [], invoice_repo.find_all_by_id(10)
  end
end
