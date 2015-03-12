class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(line)
    @id                          = line[:id].to_i
    @invoice_id                  = line[:invoice_id].to_i
    @credit_card_number          = line[:credit_card_number]
    @credit_card_expiration_date = line[:credit_card_expiration_date]
    @result                      = line[:result]
    @created_at                  = line[:created_at]
    @updated_at                  = line[:updated_at]
  end

end
