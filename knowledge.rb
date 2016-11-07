class Module
  def attribute(a, &block)
    if(a.is_a? Hash)
      a, val = a.first
    else
      instance_variable_set("@#{a}", nil)
    end

    a = a.to_sym
    var = :"@#{a}"

    define_method(a) do
      if instance_variable_defined?(var)
        instance_variable_get(var)
      else
        block ? instance_eval(&block) : val
      end
    end


    define_method("#{a}?") do
      send("#{a}")
    end

    define_method("#{a}=") do |v|
      instance_variable_set("@#{a}", v)
    end

  end
end