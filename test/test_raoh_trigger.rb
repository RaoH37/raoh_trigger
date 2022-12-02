# frozen_string_literal: true

require_relative 'test_helper'
require 'mocha/minitest'

class TestRaohTrigger < Minitest::Test
  def test_has_version_number
    refute_nil Raoh::Trigger.gem_version
  end

  def test_before_action
    assert Move.new.run(2) == 14
  end

  def test_after_action
    move = Move.new
    move.walk(2)
    assert move.step == 12
  end
end
