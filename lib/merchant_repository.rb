require_relative 'merchant'
require_relative 'merchant_parser'

class MerchantRepository
  attr_reader :merchants

  def initialize(data)
    parser = MerchantParser.new(data)
    @merchants = parser.parse
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_name(name)
    find_by_attribute(:name, name)
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

  def find_all_by_name(name)
    find_all_by_attribute(:name, name)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  private

  def find_by_attribute(attribute, given)
    merchants.detect { |merchant| merchant.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    merchants.select { |merchant| merchant.send(attribute) == given }
  end

end