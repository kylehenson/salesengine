require 'csv'
require_relative 'customer_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :customer_repository, :invoice_repository
  attr_accessor :filepath

  def initialize(filepath)
    @filepath = filepath
    @customer_repository = CustomerRepository.new("#{@filepath}/customers.csv", self)
    @invoice_repository = InvoiceRepository.new("#{@filepath}/invoices.csv", self)
  end

  def startup
    filepath = "#{@filepath}/merchants.csv"
    @merchants = CSV.open(filepath,
                          headers: true,
                          header_converters: :symbol)
    # filepath = "#{@filepath}/customers.csv"
    # @customers = CSV.open(filepath,
    #                       headers: true,
    #                       header_converters: :symbol)
    # filepath = "#{@filepath}/invoices.csv"
    # @invoices = CSV.open(filepath,
    #                       headers: true,
    #                       header_converters: :symbol)
  end
end
