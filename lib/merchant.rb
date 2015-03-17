require 'bigdecimal'                # => true
class Merchant
  attr_reader :id,                  # => :id
              :name,                # => :name
              :created_at,          # => :created_at
              :updated_at,          # => :updated_at
              :merchant_repository  # => nil

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

  def revenue
    merchant_invoice_items = successful_invoices.flat_map { |invoice| invoice.invoice_items}
    revenues = merchant_invoice_items.map { |invoice_item| invoice_item.quantity.to_i * invoice_item.unit_price.to_i }
    BigDecimal.new(revenues.reduce(:+))/100
  end

  #STACK OVERFLOW SOLUTION: http://stackoverflow.com/questions/1765368/how-to-count-duplicates-in-ruby-arrays
  def favorite_customer
    successful_customers = successful_invoices.map { |invoice| invoice.customer }
    customer_hash = successful_customers.group_by{|customer| customer.id}
    customer_hash = customer_hash.sort_by {|key, value| -value.size}
    customer_hash.first.last
  end

  def customers_with_pending_invoices
    pending_invoices = invoices.reject { |invoice| invoice.success? }
    pending_customers = pending_invoices.map {|invoice| invoice.customer}
  end

  def successful_invoices
    invoices.select { |invoice| invoice.success? }
  end
end
