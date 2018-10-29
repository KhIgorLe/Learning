module Acсessors
  def attr_accessor_with_history(*args)
    args.each do |arg|
      var_name      = "@#{arg}".to_sym
      var_name_hist = "@#{arg}_history".to_sym

      define_method(arg) { instance_variable_get(var_name) }

      define_method("#{arg}=".to_sym) do |value|
        instance_variable_set(var_name, value)

        array = instance_variable_get(var_name_hist) || []
        array << instance_variable_get(var_name)
        instance_variable_set var_name_hist, array
      end

      define_method("#{arg}_history".to_sym) { instance_variable_get(var_name_hist) }
    end
  end

  def strong_attr_accessor(name, type_class)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=") do |value|
      raise 'Значение не соответствует типу' unless value.is_a?(type_class)

      instance_variable_set(var_name, value)
    end
  end
end
