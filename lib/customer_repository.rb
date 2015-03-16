require_relative 'customer'
require_relative 'customer_parser'

class CustomerRepository
  attr_reader :customers, :sales_engine

  def initialize(data, parent)
    parser = CustomerParser.new(data)
    @customers = parser.parse
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_first_name(first_name)
    find_by_attribute(:first_name, first_name)
  end

  def find_by_last_name(last_name)
    find_by_attribute(:last_name, last_name)
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

  def find_all_by_first_name(first_name)
    find_all_by_attribute(:first_name, first_name)
  end

  def find_all_by_last_name(last_name)
    find_all_by_attribute(:last_name, last_name)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  def invoices(id)
    sales_engine.invoice_repository.find_all_by_customer_id(id)
  end

  private

  def find_by_attribute(attribute, given)
    customers.detect { |customer| customer.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    customers.select { |customer| customer.send(attribute) == given }
  end
end
