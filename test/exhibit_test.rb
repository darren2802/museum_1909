  require 'minitest/autorun'
  require_relative '../lib/exhibit'

  class TestExhibit < Minitest::Test

    def setup
      @exhibit = Exhibit.new("Gems and Minerals", 0)
    end

    def test_exhibit_initialized
      assert_instance_of Exhibit, @exhibit
      assert_equal 'Gems and Minerals', @exhibit.name
      assert_equal 0, @exhibit.cost
    end

  end
