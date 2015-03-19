require_relative 'invoice_item'
require_relative 'invoice_item_parser'

class InvoiceItemRepository
  attr_reader :invoice_items, :sales_engine

  def initialize(data, parent)
    parser = InvoiceItemParser.new(data)
    @invoice_items = parser.parse(self)
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def invoice(id)
    sales_engine.find_invoice_by_invoice_item(id)
  end

  def item(id)
    sales_engine.find_item_by_invoice_item(id)
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

  def next_id
    invoice_items.last.id + 1
  end

  def create_new_invoice_items(items, id, quantity)
    items.each do |item|
      data = {
      id:     next_id,
      item_id:  item.id,
      invoice_id: id,
      quantity: quantity[item],
      unit_price: item.unit_price,
      created_at: "#{Date.new}",
      updated_at: "#{Date.new}",
              }
      invoice_item = InvoiceItem.new(data, self)
      invoice_items << invoice_item
    end
  end

  private

  def find_by_attribute(attribute, given)
    invoice_items.detect do |invoice_item|
      invoice_item.send(attribute) == given
    end
  end

  def find_all_by_attribute(attribute, given)
    invoice_items.select do |invoice_item|
      invoice_item.send(attribute) == given
    end
  end
end
