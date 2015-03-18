require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    assert ItemRepository
  end

  def test_it_holds_seven_item_instances
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert item_repo.items.count == 7
  end

  def test_it_contains_parsed_item_objects
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    first = item_repo.items.first
    assert_equal "Item Qui Esse", first.name
  end

  def test_it_can_return_all_items
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    all = item_repo.all
    assert_equal 7, all.count
    assert_equal Item, all[0].class
  end

  def test_it_can_return_a_random_item
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    random =  item_repo.random
    assert random
    assert_equal Item, random.class
  end

  def test_it_can_find_an_instance_of_item_by_id
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal "Item Autem Minima", item_repo.find_by_id(2).name
  end

  def test_it_can_find_an_instance_of_item_by_name
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 3, item_repo.find_by_name("Item Ea Voluptatum").id
  end

  def test_it_can_find_an_instance_of_item_by_description
    description = 'Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.'
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 1, item_repo.find_by_description(description).id
  end

  def test_it_can_find_an_instance_of_item_by_unit_price
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert item_repo.find_by_unit_price(BigDecimal.new(75107)/100)
  end

  def test_it_can_find_an_instance_of_item_by_merchant_id
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 1, item_repo.find_by_merchant_id(1).id
  end

  def test_it_can_find_an_instance_of_item_by_created_at
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 1, item_repo.find_by_created_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_an_instance_of_item_by_updated_at
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 1, item_repo.find_by_updated_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_all_instances_of_item_by_id
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 2, item_repo.find_all_by_id(1).count
  end

  def test_it_can_find_all_instances_of_item_by_name
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 1, item_repo.find_all_by_name("Item Nemo Facere").count
  end

  def test_it_can_find_all_instances_of_item_by_description
    description = 'Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.'
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 2, item_repo.find_all_by_description(description).count
  end

  def test_it_can_find_all_instances_of_item_by_merchant_id
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 7, item_repo.find_all_by_merchant_id(1).count
  end

  def test_it_can_find_all_instances_of_item_by_created_at
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 7, item_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_can_find_all_instances_of_item_by_updated_at
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal 7, item_repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_returns_an_empty_array_if_no_matches_for_find_all_by_x
    item_repo = ItemRepository.new('./test/support/items.csv', nil)
    assert_equal [], item_repo.find_all_by_id(10)
  end

  def test_it_can_return_the_item_with_the_most_revenue
    engine = SalesEngine.new('./test/support')
    item_repo = engine.item_repository
    assert_equal Array, item_repo.most_revenue(1).class
    assert_equal Item, item_repo.most_revenue(1).first.class
    assert_equal 2, item_repo.most_revenue(1).first.id
  end

  def test_it_can_return_multiple_top_revenue_items
    engine = SalesEngine.new('./test/support')
    item_repo = engine.item_repository
    assert_equal 2, item_repo.most_revenue(2).count
    assert_equal 539, item_repo.most_revenue(2).last.id
  end

  def test_it_can_return_item_with_most_quantity_sold
    engine = SalesEngine.new('./test/support')
    item_repo = engine.item_repository
    assert_equal Item, item_repo.most_items(1).first.class
    assert_equal 2, item_repo.most_items(1).first.id
  end

  def test_it_can_return_multiple_items_with_most_quantity_sold
    engine = SalesEngine.new('./test/support')
    item_repo = engine.item_repository
    assert_equal Item, item_repo.most_items(2).last.class
    assert_equal 539, item_repo.most_items(2).last.id
  end

end
