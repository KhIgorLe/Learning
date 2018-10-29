module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(*args, type)
      @validations ||= {}
      @validations[type.keys.first] = [type, args: args]
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
      self.class.validations.each do |validation|
        key, value = validation
        type, args = value

        send("validate_#{key}_of", args[:args], type)
      end
    end

    def validate_presence_of(args, _type)
      args.each do |arg|
        message = "#{arg} не может быть пустым"

        if send(arg).is_a?(Array)
          raise message if send(arg).empty?
        else
          raise message if send(arg).to_s.empty?
        end
      end
    end

    def validate_format_of(args, type)
      args.each do |arg|
        raise "#{arg} имеет неверный формат" if send(arg).to_s !~ type[:format]
      end
    end

    def validate_length_min_of(args, type)
      args.each do |arg|
        if send(arg).is_a?(Array)
          array_size_min(arg, type)
        else
          row_length_min(arg, type)
        end
      end
    end

    def array_size_min(arg, type)
      return unless send(arg).compact.size < type[:length_min].to_i

      raise "#{arg} должно быть минимум #{type[:length_min]}"
    end

    def row_length_min(arg, type)
      return unless send(arg).to_s.length < type[:length_min].to_i

      raise "#{arg} не может быть меньше #{type[:length_min]} символов"
    end

    def validate_uniqueness_of(args, _type)
      args.each do |arg|
        if self.class.all.map(&arg).include?(send(arg))
          raise "#{self.class} с таким #{arg} уже существует"
        end
      end
    end

    def validate_type_of(args, type)
      args.each do |arg|
        if send(arg).is_a?(Array)
          send(arg).each { |line| invalid_type(line, type) }
        else
          invalid_type(send(arg), type)
        end
      end
    end

    def invalid_type(arg, type)
      raise "#{arg} содержит неверный тип" unless arg.is_a?(type[:type])
    end
  end
end
