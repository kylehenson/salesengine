require_relative 'test_helper'
require_relative '../lib/merchant_parser'
require_relative '../lib/merchant'


class MerchantTest < Minitest::Test

  def test_it_exists
    assert Merchant
  end

  def test_merchant_has_name_and_id
    file = CSV.open("./test/support/merchants.csv", headers: true, header_converters: :symbol)
    first = file.first
    merchant = Merchant.new(first, nil)
    assert_equal 1, merchant.id
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_merchant_has_other_merchant_attributes
    file = CSV.open("./test/support/merchants.csv", headers: true, header_converters: :symbol)
    first = file.first
    merchant = Merchant.new(first, nil)
    created_time = '2012-03-27 14:53:59 UTC'
    assert_equal created_time, merchant.created_at
  end

  class MerchantIntegrationTest < Minitest::Test
    attr_reader :engine

    def setup
      @engine = SalesEngine.new('./test/support/')
    end

    def test_it_can_receive_data_from_invoice_repo
      merchant = engine.merchant_repository.merchants[0]
      assert_equal Invoice, merchant.invoices[0].class
    end

    def test_it_can_receive_data_from_item_repo
      merchant = engine.merchant_repository.merchants[0]
      assert_equal Item, merchant.items[0].class
    end
  end

end
