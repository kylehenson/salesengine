class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :customer_repository

  def initialize(line, parent)
    @id                  = line[:id].to_i
    @first_name          = line[:first_name]
    @last_name           = line[:last_name]
    @created_at          = line[:created_at]
    @updated_at          = line[:updated_at]
    @customer_repository = parent
  end

  def invoices
    customer_repository.invoices(id)
  end


end
