class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :invoice_item_repository

  def initialize(line, parent)
    @id          = line[:id].to_i
    @item_id     = line[:item_id].to_i
    @invoice_id  = line[:invoice_id].to_i
    @quantity    = line[:quantity].to_i
    @unit_price  = line[:unit_price]
    @created_at  = line[:created_at]
    @updated_at  = line[:updated_at]
    @invoice_item_repository = parent
  end

  def invoice
    invoice_item_repository.invoice(invoice_id)
  end

  def item
    invoice_item_repository.item(item_id)
  end

end
