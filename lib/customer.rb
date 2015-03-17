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

  def transactions
    transactions_array = invoices.map {|invoice| invoice.transactions }
    transactions_array.flatten
  end

  def favorite_merchant
    successful_merchants = successful_invoices.map { |invoice| invoice.merchant }
    merchant_hash = successful_merchants.group_by { |merchant| merchant.id }
    merchant_list_by_id = merchant_hash.sort_by { |key, value| -value.size }
    favorite_id = merchant_list_by_id.first
    favorite_id.flatten.last
  end

  def successful_invoices
    invoices.select { |invoice| invoice.success?}
  end
end
