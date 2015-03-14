require_relative 'invoice_item'
require_relative 'invoice_item_parser'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(data)
    parser = InvoiceItemParser.new(data)
    @invoice_items = parser.parse
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_item_id(item_id)
    find_by_attribute(:item_id, item_id)
  end

  def find_by_invoice_id(invoice_id)
    find_by_attribute(:invoice_id, invoice_id)
  end

  def find_by_quantity(quantity)
    find_by_attribute(:quantity, quantity)
  end

  def find_by_unit_price(unit_price)
    find_by_attribute(:unit_price, unit_price)
  end

  def find_by_created_at(created_at)
    find_by_attribute(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by_attribute(:updated_at, updated_at)
  end

  def find_all_by_id(id)
    find_all_by_attribute(:id, id)
  end

  def find_all_by_item_id(item_id)
    find_all_by_attribute(:item_id, item_id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_attribute(:invoice_id, invoice_id)
  end

  def find_all_by_quantity(quantity)
    find_all_by_attribute(:quantity, quantity)
  end

  def find_all_by_unit_price(unit_price)
    find_all_by_attribute(:unit_price, unit_price)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  private

  def find_by_attribute(attribute, given)
    invoice_items.detect { |invoice_item| invoice_item.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    invoice_items.select { |invoice_item| invoice_item.send(attribute) == given }
  end
end
