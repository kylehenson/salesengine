require_relative 'invoice'
require_relative 'invoice_parser'

class InvoiceRepository
  attr_reader :invoices, :sales_engine, :item_quantities

  def initialize(data, parent)
    parser = InvoiceParser.new(data)
    @invoices = parser.parse(self)
    @sales_engine = parent
  end

  def customer(id)
    sales_engine.find_customer_by_invoice(id)
  end

  def merchant(id)
    sales_engine.find_merchant_by_invoice(id)
  end

  def items(id)
    sales_engine.find_items_by_invoice(id)
  end

  def transactions(id)
    sales_engine.find_transactions_by_invoice(id)
  end

  def invoice_items(id)
    sales_engine.find_invoice_items_by_invoice(id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_customer_id(customer_id)
    find_by_attribute(:customer_id, customer_id)
  end

  def find_by_merchant_id(merchant_id)
    find_by_attribute(:merchant_id, merchant_id)
  end

  def find_by_status(status)
    find_by_attribute(:status, status)
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

  def find_all_by_customer_id(customer_id)
    find_all_by_attribute(:customer_id, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_attribute(:merchant_id, merchant_id)
  end

  def find_all_by_status(status)
    find_all_by_attribute(:status, status)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  def create_quantity_hash(inputs)
    @item_quantities = Hash.new(0)
    inputs[:items].each do |item|
      @item_quantities[item] += 1
    end
  end

  def create(inputs)
    data =  {
      id:           "#{invoices.last.id + 1}",
      customer_id:  inputs[:customer].id,
      merchant_id:  inputs[:merchant].id,
      status:       inputs[:status],
      created_at:   "#{Date.new}",
      updated_at:   "#{Date.new}"
        }

    new_invoice = Invoice.new(data, self)
    invoices << new_invoice
    create_quantity_hash(inputs)
    sales_engine.create_new_items_with_invoice_id(inputs[:items], new_invoice.id, @item_quantities)
    new_invoice
  end

  def new_charge(card_info, id)
    sales_engine.new_charge(card_info, id)
  end

  private

  def find_by_attribute(attribute, given)
    invoices.detect { |invoice| invoice.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    invoices.select { |invoice| invoice.send(attribute) == given }
  end
end
