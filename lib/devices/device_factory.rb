$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

class DeviceFactory
  @@allDevices = []
  @@capabilities = {}

  def self.register_device deviceType
    @@allDevices.push deviceType
    puts "Created a #{deviceType.class}"
    #@@capabilities[deviceType] = @@allDevices[deviceType].requests
  end

  def self.create deviceType
    puts "TO: create called here."
    dt = @@allDevices[deviceType]
    if dt
      dt
    else
      raise "DeviceType #{deviceType} is not registered."
    end
  end

  def self.connect( dev )
    if dev.is_a? Numeric
      return by_index( dev )
    else
      return by_name( dev )
    end
  end
  
  def self.by_index( index )
    @@allDevices[index]
  end

  def self.by_name( name )
    @@allDevices.select {|dev| dev.name == name}.first
  end

  def self.devices
    @@allDevices.collect {|dev| [dev.class.to_s, dev.name]}
  end

  def self.capabilities
    @@capabilities
  end

end