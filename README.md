# raoh_trigger
Provide `before_action` and `after_action` class method

```ruby
class Move < RaohTrigger::Base
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

move = Move.new
puts move.run(2)
=> 14
puts move.step
=> 14
puts move.walk(2)
=> 16
puts move.step
=> 26
```

## Installation

TODO

## Options

TODO

## Usage

TODO