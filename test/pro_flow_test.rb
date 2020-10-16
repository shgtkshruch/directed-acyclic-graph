require "minitest/autorun"
require_relative 'item'
require_relative '../workflow/pro_flow'

class ProFlowTest < Minitest::Test
  def setup
    item = Item.new
    @pro_flow = ProFlow.new(item)
  end

  def test_valid?
    assert_equal true, @pro_flow.valid?
  end

  def test_invalid?
    assert_equal false, @pro_flow.invalid?
  end

  def test_done
    assert_equal [:ca, :kr], @pro_flow.done
  end

  def test_not_done
    assert_equal [:ba, :ua, :qt, :da, :rc, :rp], @pro_flow.not_done
  end

  def test_get_ready?
    assert_equal true, @pro_flow.get_ready?(:ba)
    assert_equal false, @pro_flow.get_ready?(:da)
  end

  def test_get_ready
    assert_equal [:ba, :ua], @pro_flow.get_ready
  end
end
