require_relative 'merchant'
require_relative 'merchant_parser'

class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(data, parent)
    parser = MerchantParser.new(data)
    @merchants = parser.parse(self)
    @sales_engine = parent
  end

  # def revenue(date)
  #   all_revenues = merchants.map {|merchant| merchant.revenue(date)}
  #   require'pry';binding.pry
  #   BigDecimal.new(all_revenues.to_i.reduce(:+))
  # end

  def most_revenue(x)
    merchants_sorted_by_revenue = merchants.sort_by { |merchant| merchant.total_merchant_revenue }
    merchants_sorted_by_revenue.reverse.first(x)
  end

  def most_items(x)
    merchants_sorted_by_items = merchants.sort_by { |merchant| merchant.total_merchant_items }
    merchants_soreted_by_items.reverse.first(x)
  end

  def items(id)
    sales_engine.find_items_by_merchant(id)
  end

  def invoices(id)
    sales_engine.find_invoices_by_merchant(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_name(name)
    find_by_attribute(:name, name)
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

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  private

  def find_by_attribute(attribute, given)
    merchants.detect { |merchant| merchant.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    merchants.select { |merchant| merchant.send(attribute) == given }
  end

end
