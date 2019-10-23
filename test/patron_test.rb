require 'minitest/autorun'
require_relative '../lib/patron'

class TestPatron < Minitest::Test

  def setup
    @bob = Patron.new("Bob", 20)
  end

  def test_patron_initialized
    assert_instance_of Patron, @bob
    assert_equal 'Bob', @bob.name
    assert_equal 20, @bob.spending_money
    assert_equal [], @bob.interests
  end

  def test_patron_add_interests
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @bob.interests
  end

end
