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
      merchant_invoice_items = successful_invoices.flat_map do |invoice|
         invoice.invoice_items
       end
    else
      given_date_invoices = successful_invoices.select do |invoice|
        invoice.created_at.to_s == date.to_s
      end
      merchant_invoice_items = given_date_invoices.flat_map do |invoice|
        invoice.invoice_items
      end
    end
      revenues = merchant_invoice_items.map do |invoice_item|
        invoice_item.revenue
      end
      BigDecimal.new(revenues.reduce(:+))/100
  end

  def favorite_customer
    successful_customers = successful_invoices.map do |invoice|
       invoice.customer
    end
    customer_hash = successful_customers.group_by do |customer|
      customer.id
    end
    customer_list_by_id = customer_hash.sort_by do |key, value|
       -value.size
     end
    favorite_id = customer_list_by_id.first
    favorite_id.flatten.last
  end

  def customers_with_pending_invoices
    pending_invoices = invoices.reject { |invoice| invoice.success? }
    pending_customers = pending_invoices.map {|invoice| invoice.customer}
  end

  def total_merchant_revenue
   revenues = successful_invoice_items.map do |invoice_item|
      invoice_item.revenue
    end
   revenues.reduce(:+)
 end

 def total_merchant_items
   quantities = successful_invoice_items.map do |invoice_item|
      invoice_item.quantity
    end
   quantities.reduce(:+)
 end

 def successful_invoice_items
   successful_invoices.flat_map { |invoice| invoice.invoice_items }
 end

 def successful_invoices
   invoices.select { |invoice| invoice.success? }
 end
end
