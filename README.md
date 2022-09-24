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
move.run(2)
puts move.step
=> 14
move.walk(2)
puts move.step
=> 16
```

## Installation

TODO

## Options

TODO

## Usage

TODO