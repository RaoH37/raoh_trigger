# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'raoh_trigger'

require 'minitest/autorun'

class Move < Raoh::Trigger::Base
  before_action :jump, only: %i[run]
  after_action :jump, only: %i[walk]

  attr_reader :step

  def initialize
    super
    @step = 0
  end

  def walk(step)
    @step += step
  end

  def run(step)
    @step += (step * 2)
  end

  private

  def jump
    @step += 10
  end
end