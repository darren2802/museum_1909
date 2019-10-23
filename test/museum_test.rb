require 'minitest/autorun'
require_relative '../lib/museum'
require_relative '../lib/exhibit'
require_relative '../lib/patron'

class TestMuseum < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
  end

  def test_museum_initialized
    assert_instance_of Museum, @dmns
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_museum_add_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_museum_recommended_exhibits_bob
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@bob)
  end

  def test_museum_recommended_exhibits_sally
    @sally.add_interest("IMAX")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_museum_admit_patrons
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")
    assert_equal [], @dmns.patrons
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_museum_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    interests = {
      @gems_and_minerals => [@bob],
      @dead_sea_scrolls => [@bob, @sally],
      @imax => []
    }
    assert_equal interests, @dmns.patrons_by_exhibit_interest
  end

  def test_museum_spending_money_tj
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    tj = Patron.new("TJ", 7)
    tj.add_interest("IMAX")
    tj.add_interest("Dead Sea Scrolls")
    @dmns.admit(tj)
    assert_equal 7, tj.spending_money
  end

  def test_museum_spending_money_bob
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @bob.spending_money -= 10
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("IMAX")
    @dmns.admit(@bob)
    assert_equal 0, @bob.spending_money
  end

  def test_museum_spending_money_sally
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @sally.add_interest("Dead Sea Scrolls")
    @sally.add_interest("IMAX")
    @dmns.admit(@sally)
    assert_equal 5, @sally.spending_money
  end

  def test_museum_spending_money_morgan
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    morgan = Patron.new("Morgan", 15)
    morgan.add_interest("Dead Sea Scrolls")
    morgan.add_interest("Gems and Minerals")
    @dmns.admit(morgan)
    assert_equal 5, morgan.spending_money
  end

  def test_museum_revenue
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    tj = Patron.new("TJ", 7)
    tj.add_interest("IMAX")
    tj.add_interest("Dead Sea Scrolls")
    @dmns.admit(tj)

    @bob.spending_money -= 10
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("IMAX")
    @dmns.admit(@bob)


    @sally.add_interest("Dead Sea Scrolls")
    @sally.add_interest("IMAX")
    @dmns.admit(@sally)

    morgan = Patron.new("Morgan", 15)
    morgan.add_interest("Dead Sea Scrolls")
    morgan.add_interest("Gems and Minerals")
    @dmns.admit(morgan)

    assert_equal 35, @dmns.revenue

  end

end
