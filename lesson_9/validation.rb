module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(*attr_names, **args)
      type = args.keys.first

      @validations ||= {}
      @validations[type] = { attributes: attr_names, arg: args[type] }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate!
      self.class.validations.each do |type, options|
        options[:attributes].each do |attr_name|
          send("validate_#{type}_of", attr_name, options[:arg])
        end
      end
    end

    def validate_presence_of(attr_name, _arg)
      message = "#{attr_name} не может быть пустым"

      if send(attr_name).is_a?(Array)
        raise message if send(attr_name).empty?
      else
        raise message if send(attr_name).to_s.empty?
      end
    end

    def validate_format_of(attr_name, arg)
      raise "#{attr_name} имеет неверный формат" if send(attr_name).to_s !~ arg
    end

    def validate_length_min_of(attr_name, arg)
      if send(attr_name).is_a?(Array)
        array_size_min(attr_name, arg)
      else
        row_length_min(attr_name, arg)
      end
    end

    def array_size_min(attr_name, arg)
      return unless send(attr_name).compact.size < arg.to_i

      raise "#{attr_name} должно быть минимум #{arg}"
    end

    def row_length_min(attr_name, arg)
      return unless send(attr_name).to_s.length < arg.to_i

      raise "#{attr_name} не может быть меньше #{arg} символов"
    end

    def validate_uniqueness_of(attr_name, _arg)
      if self.class.all.map(&attr_name).include?(send(attr_name))
        raise "#{self.class} с таким #{attr_name} уже существует"
      end
    end

    def validate_type_of(attr_name, arg)
      if send(attr_name).is_a?(Array)
        send(attr_name).each { |line| invalid_type(line, arg) }
      else
        invalid_type(send(attr_name), arg)
      end
    end

    def invalid_type(attr_name, arg)
      raise "#{attr_name} содержит неверный тип" unless attr_name.is_a?(arg)
    end
  end
end
