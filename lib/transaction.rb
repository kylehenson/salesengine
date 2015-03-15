class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :transaction_repository

  def initialize(line, parent)
    @id                          = line[:id].to_i
    @invoice_id                  = line[:invoice_id].to_i
    @credit_card_number          = line[:credit_card_number]
    @credit_card_expiration_date = line[:credit_card_expiration_date]
    @result                      = line[:result]
    @created_at                  = line[:created_at]
    @updated_at                  = line[:updated_at]
    @transaction_repository      = parent
  end

  def invoice
    transaction_repository.sales_engine.invoice_repository.find_by_id(invoice_id)
  end


end
