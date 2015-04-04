$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

require 'serial_comm'

class Arduino < SerialComm
  
  attr_accessor :name
  
  def initialize
    @name = "My Arduino"
    @port = "/dev/ttyUSB0"
    super @port
  end

  def status
    write_chars 's'
    read_chars
  end

  def set_reference( args )
    cmd = "r#{args}"
    write_chars cmd
    read_chars
  end

  def get_message
    read_chars
  end

end