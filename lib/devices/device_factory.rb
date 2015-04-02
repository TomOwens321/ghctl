$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

class DeviceFactory
  @@devices = {}
  @@capabilities = {}

  def self.register_device deviceType
    @@devices[deviceType] = self.new
    #@@capabilities[deviceType] = @@devices[deviceType].requests
  end

  def self.create deviceType
    dt = @@devices[deviceType]
    if dt
      dt
    else
      raise "DeviceType #{deviceType} is not registered."
    end
  end

  def self.devices
    @@devices
  end

  def self.capabilities
    @@capabilities
  end

end