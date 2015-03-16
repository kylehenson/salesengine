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

end
