require 'bigdecimal'
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

  def revenue
    successful_invoices
    merchant_invoice_items = successful_invoices.flat_map { |invoice| invoice.invoice_items}
    revenues               = merchant_invoice_items.map { |invoice_item| invoice_item.quantity.to_i * invoice_item.unit_price.to_i }
    BigDecimal.new(revenues.reduce(:+))/100
  end


  def successful_invoices
    invoices.select { |invoice| invoice.success? }
  end
end
