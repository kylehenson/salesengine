require_relative 'transaction'
require_relative 'transaction_parser'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(data, parent)
    parser = TransactionParser.new(data)
    @transactions = parser.parse(self)
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def invoice(id)
    sales_engine.find_invoice_by_transaction(id)
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_invoice_id(invoice_id)
    find_by_attribute(:invoice_id, invoice_id)
  end

  def find_by_credit_card_number(credit_card_number)
    find_by_attribute(:credit_card_number, credit_card_number)
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    find_by_attribute(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_by_result(result)
    find_by_attribute(:result, result)
  end

  def find_by_created_at(created_at)
    find_by_attribute(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by_attribute(:updated_at, updated_at)
  end

  def find_all_by_id(id)
    find_all_by_attribute(:id, id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_attribute(:invoice_id, invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all_by_attribute(:credit_card_number, credit_card_number)
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    find_all_by_attribute(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_all_by_result(result)
    find_all_by_attribute(:result, result)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  def next_id
    transactions.last.id + 1
  end

  def new_charge(card_info, id)
    card_info = {
      id:                     next_id,
      invoice_id:             id,
      credit_card_number:     card_info[:credit_card_number],
      credit_card_expiration: card_info[:credit_card_expiration],
      result:                 card_info[:result],
      created_at:             "#{Date.new}",
      updated_at:             "#{Date.new}"
    }

    new_transaction = Transaction.new(card_info, self)
    transactions << new_transaction
  end

  private

  def find_by_attribute(attribute, given)
    transactions.detect { |transaction| transaction.send(attribute) == given}
  end

  def find_all_by_attribute(attribute, given)
    transactions.select { |transaction| transaction.send(attribute) == given}
  end

end
