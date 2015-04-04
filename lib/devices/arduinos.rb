$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

require 'device'
require 'arduino'

arduino = Arduino.new
Device.register_device arduino