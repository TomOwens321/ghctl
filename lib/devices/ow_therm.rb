$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

require 'device'
require 'thermometer'

class OwTherm < Device

  def initialize
    @therm = Thermometer.new(nil,nil)
    @requests = []
  end

  register_device :owTherm
end