require'date'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repository

  def initialize(line, parent)
    @id                 = line[:id].to_i
    @customer_id        = line[:customer_id].to_i
    @merchant_id        = line[:merchant_id].to_i
    @status             = line[:status]
    @created_at         = Date.parse(line[:created_at])
    @updated_at         = line[:updated_at]
    @invoice_repository = parent
  end

  def customer
    invoice_repository.customer(customer_id)
  end

  def merchant
    invoice_repository.merchant(merchant_id)
  end

  def transactions
    invoice_repository.transactions(id)
  end

  def invoice_items
    invoice_repository.invoice_items(id)
  end

  def items
    invoice_items.map do |invoice_item|
      invoice_item.item
    end
  end

  def success?
    transactions.any? { |transaction| transaction.result == "success"}
  end

  def add_items(items_array)
    item_ids = items_array.group_by {|item| item.id}
  #call group by on items to group items by item_id
  #iterate through that result
    invoice_items = item_ids.map do |k, v|
      data = {
          id:         invoice_item_repository.next_id
          item_id:    v.first.id
          invoice_id: invoice_repository.next_id
          quantity:   v.size
          unit_price: v.first.unit_price
          created_at: Time.now
          updated_at: Time.now
          }
          invoice_item_repo.invoice_items << InvoiceItem.new(data, invoice_item_repo)
        end

  def invoice_item_repo
    self.engine.invoice_item_repository
  end

  def charge(credit_card_hash)

  end

end
