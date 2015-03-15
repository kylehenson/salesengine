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
    @created_at         = line[:created_at]
    @updated_at         = line[:updated_at]
    @invoice_repository = parent
  end

  def customer
    invoice_repository.customer(customer_id)
  end

  def merchant
    invoice_repository.merchant(merchant_id)
  end

end
