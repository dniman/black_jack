# frozen_string_literal: true

# Validation
module Validation
  def self.included(klass)
    klass.include InstanceMethods
    klass.extend ClassMethods
  end

  # instance methods
  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attr = instance_variable_get("@#{validation[:attr_name]}".to_sym)
        send("validate_#{validation[:validation_type]}", attr, validation[:args])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate_presence(attr, _args)
      raise 'Value can\'t be emtpy!' if attr.nil? || (attr.is_a?(String) && attr.empty?)
    end

    def validate_type(attr, args)
      raise 'Value type doesn\'t match the specified class!' unless attr.is_a?(args[0])
    end

    def validate_range(attr, args)
      raise 'Value not found in specified range!' unless args[0].include?(attr)
    end

    def validate_presence_in_array(attr, args)
      raise 'Value not found in specified array!' unless args[0].include?(attr)
    end
  end

  # class methods
  module ClassMethods
    attr_reader :validations

    def validate(name, type, *args)
      @validations ||= []
      @validations << { attr_name: name, validation_type: type, args: args }
    end
  end
end
