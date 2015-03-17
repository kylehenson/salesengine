require 'bigdecimal'
require 'bigdecimal/util'
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(line, parent)
    @id                  = line[:id].to_i
    @name                = line[:name]
    @created_at          = line[:created_at]
    @updated_at          = line[:updated_at]
    @merchant_repository = parent
  end

  def items
    merchant_repository.items(id)
  end

  def invoices
    merchant_repository.invoices(id)
  end

  def revenue(date=nil)
    if date==nil
      merchant_invoice_items = successful_invoices.flat_map { |invoice| invoice.invoice_items}
      revenues = merchant_invoice_items.map { |invoice_item| invoice_item.quantity.to_i * invoice_item.unit_price.to_i }
      BigDecimal.new(revenues.reduce(:+))/100
    else
      given_date_invoices = successful_invoices.select {|invoice| invoice.created_at.to_s == date.to_s }
      merchant_invoice_items = given_date_invoices.flat_map { |invoice| invoice.invoice_items }
      revenues = merchant_invoice_items.map { |invoice_item| invoice_item.quantity.to_i * invoice_item.unit_price.to_i }
      revenues.reduce(:+).to_d/100
    end
  end

  #STACK OVERFLOW SOLUTION: http://stackoverflow.com/questions/1765368/how-to-count-duplicates-in-ruby-arrays
  def favorite_customer
    successful_customers = successful_invoices.map { |invoice| invoice.customer }
    customer_hash = successful_customers.group_by{|customer| customer.id}
    customer_list_by_id = customer_hash.sort_by {|key, value| -value.size}
    favorite_id = customer_list_by_id.first
    favorite_id.flatten.last
  end

  def customers_with_pending_invoices
    pending_invoices = invoices.reject { |invoice| invoice.success? }
    pending_customers = pending_invoices.map {|invoice| invoice.customer}
  end

  def successful_invoices
    invoices.select { |invoice| invoice.success? }
  end
end
