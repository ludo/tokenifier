require 'tokenifier'

def without_const(const)
  if Object.const_defined?(const)
    begin
      @const = const
      Object.send(:remove_const, const)
      yield
    ensure
      Object.const_set(const, @const)
    end
  else
    yield
  end
end

def with_stub_const(const, value)
  if Object.const_defined?(const)
    begin
      @const = const
      Object.const_set(const, value)
      yield
    ensure
      Object.const_set(const, @const)
    end
  else
    begin
      Object.const_set(const, value)
      yield
    ensure
      Object.send(:remove_const, const)
    end
  end
end