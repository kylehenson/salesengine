require_relative 'item'
require_relative 'item_parser'

class ItemRepository
  attr_reader :items, :sales_engine

  def initialize(data, parent)
    parser        = ItemParser.new(data)
    @items        = parser.parse(self)
    @sales_engine = parent
  end

  def most_revenue(x)
    items_sorted_by_revenue = items.sort_by do |item|
      item.total_item_revenue.nil? ? 0 : item.total_item_revenue
    end
    items_sorted_by_revenue.reverse.first(x)
  end

  def most_items(x)
    items_sorted_by_quantity = items.sort_by do |item|
       item.total_item_quantity.nil? ? 0 : item.total_item_quantity
     end
    items_sorted_by_quantity.reverse.first(x)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def merchant(id)
    sales_engine.find_merchant_by_item(id)
  end

  def invoice_items(id)
    sales_engine.find_invoice_items_by_item(id)
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_name(name)
    find_by_attribute(:name, name)
  end

  def find_by_description(description)
    find_by_attribute(:description, description)
  end

  def find_by_unit_price(unit_price)
    find_by_attribute(:unit_price, unit_price)
  end

  def find_by_merchant_id(merchant_id)
    find_by_attribute(:merchant_id, merchant_id)
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

  def find_all_by_name(name)
    find_all_by_attribute(:name, name)
  end

  def find_all_by_description(description)
    find_all_by_attribute(:description, description)
  end

  def find_all_by_unit_price(unit_price)
    find_all_by_attribute(:unit_price, unit_price)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_attribute(:merchant_id, merchant_id)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  private

  def find_by_attribute(attribute, given)
    items.detect { |item| item.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    items.select { |item| item.send(attribute) == given }
  end
end
