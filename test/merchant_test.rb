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
    merchant = Merchant.new(first)
    assert_equal 1, merchant.id
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_merchant_has_other_merchant_attributes
    file = CSV.open("./test/support/merchants.csv", headers: true, header_converters: :symbol)
    first = file.first
    merchant = Merchant.new(first)
    created_time = '2012-03-27 14:53:59 UTC'
    assert_equal created_time, merchant.created_at
  end

end
