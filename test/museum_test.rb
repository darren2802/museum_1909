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

end
