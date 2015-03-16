require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    assert InvoiceItemRepository
  end

  def test_it_holds_seven_invoice_item_instances
    invoice_item_repo = InvoiceItemRepository.new('./test/support/invoice_items.csv', nil)
    assert invoice_item_repo.invoice_items.count == 8
  end

  def test_it_contains_parsed_invoice_item_objects
    invoice_item_repo = InvoiceItemRepository.new('./test/support/invoice_items.csv', nil)
    first = invoice_item_repo.invoice_items.first
    assert_equal 1, first.invoice_id
  end

  def test_all_returns_a_collection_of_invoice_items
    invoice_item_repo = InvoiceItemRepository.new('./test/support/invoice_items.csv', nil)
    all = invoice_item_repo.all
    assert_equal 8, all.count
    assert_equal InvoiceItem, all.first.class
  end

  def test_random_returns_an_instance_of_invoice_item
    invoice_item_repo = InvoiceItemRepository.new('./test/support/invoice_items.csv', nil)
    assert_equal InvoiceItem, invoice_item_repo.random.class
  end

  def test_it_can_find_by_id
    invoice_item_repo = InvoiceItemRepository.new('./test/support/invoice_items.csv', nil)
    assert_equal 539, invoice_item_repo.find_by_id(1).item_id
  end

  def test_it_can_find_by_item_id
    invoice_item_repo = InvoiceItemRepository.new('./test/support/invoice_items.csv', nil)
    assert_equal 2, invoice_item_repo.find_by_item_id(528).id
  end

  def test_it_can_find_by_invoice_id
  end

  def test_it_returns_an_empty_array_if_no_matches_for_find_all_by_x
    invoice_item_repo = InvoiceItemRepository.new('./test/support/invoice_items.csv', nil)
    assert_equal [], invoice_item_repo.find_all_by_id(10)
  end
end
