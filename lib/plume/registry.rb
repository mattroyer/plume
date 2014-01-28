require 'win32/registry'

class Registry
  def initialize(base = 'HKEY_CURRENT_USER', location, key, value)
    @base = base
    @location = location
    @key = key
    @value = value
  end

  def set_registry
    command = Win32::Registry::const_get(@base).open @location, @Win32::Registry::KEY_ALL_ACCESS

    if command[@key] == @value
      puts "Value already set to #{command[@key]}"
    else
      command[@key] = @value
    end
  end

  def get_registry
    command = Win32::Registry::const_get(@base).open @location, Win32::Registry::KEY_ALL_ACCESS

    puts "Value is: #{command[@key]}"
  end
end
