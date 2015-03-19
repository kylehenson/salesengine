require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :item_repository

  def initialize(line, parent)
    @id              = line[:id].to_i
    @name            = line[:name]
    @description     = line[:description]
    @unit_price      = BigDecimal.new(line[:unit_price])/100
    @merchant_id     = line[:merchant_id].to_i
    @created_at      = line[:created_at]
    @updated_at      = line[:updated_at]
    @item_repository = parent
  end

  def invoice_items
    item_repository.invoice_items(id)
  end

  def merchant
    item_repository.merchant(merchant_id)
  end

  def best_day
    maximum_item = invoice_items.max_by { |invoice_item| invoice_item.quantity }
    maximum_item.invoice.created_at
  end

  def successful_invoice_items
    invoice_items.select { |invoice_item| invoice_item.success? }
  end

  def total_item_revenue
    revenues = successful_invoice_items.map do |invoice_item|
      invoice_item.revenue
    end
    revenues.reduce(:+)
  end

  def total_item_quantity
    quantities = successful_invoice_items.map do |invoice_item|
       invoice_item.quantity
     end
    quantities.reduce(:+)
  end

end
