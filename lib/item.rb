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
    @unit_price      = line[:unit_price]
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

end
