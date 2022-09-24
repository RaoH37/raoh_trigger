# frozen_string_literal: true

module RaohTrigger
  # Abstract Class to provide before_action and after_action class method
  class Base
    BEFORE = :before
    AFTER = :after

    class << self
      @@recorded_triggers = []
      @@options_action = { only: %i[], except: %i[], args: [] }

      def before_action(method_name, options = {})
        add_action(BEFORE, method_name, options)
      end

      def after_action(method_name, options = {})
        add_action(AFTER, method_name, options)
      end

      def add_action(scope, method_name, options)
        options = @@options_action.merge(options)
        args = options.delete(:args)
        scoped_method_names = options.delete(:only)
        unscoped_method_names = options.delete(:except)

        @@recorded_triggers << RecordedTrigger.new(scope, method_name, args, scoped_method_names, unscoped_method_names)
      end
    end

    def initialize
      override_methods
    end

    def override_methods
      format_recorded_triggers

      all_recorded_trigger_scoped_method_names.each do |defined_method|
        before_recorded_triggers = select_recorded_triggers(BEFORE, defined_method)
        after_recorded_triggers = select_recorded_triggers(AFTER, defined_method)

        next if before_recorded_triggers.empty? && after_recorded_triggers.empty?

        override_method(defined_method, before_recorded_triggers, after_recorded_triggers)
      end
    end

    def override_method(method_name, before_triggers, after_triggers)
      origin_method_name = backup_original_method(method_name)
      refine_method(origin_method_name, method_name, before_triggers, after_triggers)
    end

    def refine_method(origin_method_name, method_name, before_triggers, after_triggers)
      define_singleton_method(method_name) do |*args|
        before_triggers.each do |trigger|
          send(trigger.method_name, *trigger.args)
        end

        origin_result = send(origin_method_name, *args)

        after_triggers.each do |trigger|
          send(trigger.method_name, *trigger.args)
        end

        origin_result
      end
    end

    def backup_original_method(method_name)
      origin_method_name = "origin_#{method_name}".to_sym
      origin_method = method(method_name)

      define_singleton_method(origin_method_name) do |*args|
        origin_method.call(*args)
      end

      origin_method_name
    end

    def format_recorded_triggers
      all_recorded_trigger_method_names = @@recorded_triggers.map(&:method_name)

      @@recorded_triggers.select do |recorded_trigger|
        recorded_trigger.scoped_method_names.empty?
      end.each do |recorded_trigger|
        recorded_trigger.scoped_method_names = defined_methods - recorded_trigger.unscoped_method_names - all_recorded_trigger_method_names
      end
    end

    def select_recorded_triggers(scope, defined_method)
      @@recorded_triggers.select do |recorded_trigger|
        recorded_trigger.scope == scope && recorded_trigger.scoped_method_names.include?(defined_method)
      end
    end

    def all_recorded_trigger_scoped_method_names
      @@recorded_triggers.map(&:scoped_method_names).flatten.uniq
    end

    def defined_methods
      private_methods(false) + public_methods(false)
    end
  end
end
