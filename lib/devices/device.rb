$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

require 'device_factory'

class Device < DeviceFactory
  attr_reader :status

  def initialize
    @status = [:present]
  end

  def self.by_index( index )
    @@allDevices[index]
  end

end