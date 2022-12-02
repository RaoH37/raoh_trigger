# frozen_string_literal: true

module Raoh
  module Trigger
      # Class to record before_action or after_action calls
      class RecordedTrigger
        attr_reader :scope, :method_name, :args, :unscoped_method_names
        attr_accessor :scoped_method_names

        def initialize(scope, method_name, args, scoped_method_names, unscoped_method_names)
          @scope = scope
          @method_name = method_name
          @args = args
          @scoped_method_names = scoped_method_names
          @unscoped_method_names = unscoped_method_names
        end
      end
  end
end
