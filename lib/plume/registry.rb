require 'win32/registry'

class Registry
  def initialize(base = 'HKEY_CURRENT_USER', location, key, value)
    @base = base
    @location = location
    @key = key
    @value = value
  end

  def set_registry
    command = Win32::Registry::const_get(@base).open @location, Win32::Registry::KEY_ALL_ACCESS

    keys = command[@key].split(';').map { |key| key.downcase }

    if keys.any? { |key| key.include?(@value.downcase) }
      puts "Value already set to #{command[@key]}"
    else
      command[@key] = "#{get_registry};#{@value}"
    end
  end

  def get_registry
    command = Win32::Registry::const_get(@base).open @location, Win32::Registry::KEY_ALL_ACCESS

    command[@key]
  end
end
