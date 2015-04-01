require 'serialport'

class SerialComm

  def initialize( port )
    @port = port
    @baud = 9600
    @dataBits = 8
    @stopBits = 1
    @parity = SerialPort::NONE
    start
  end
  
  def read_chars
    if IO.select([@comm],nil,nil,5)
      sleep(1)
      msg = @comm.gets.chomp
    end
    p msg
  end
  
  def write_chars( msg )
    if IO.select(nil,[@comm],nil,1)
      @comm.puts( msg )
    end
  end
  
  def start
    @comm = SerialPort.new(@port,@baud,@dataBits,@stopBits,@parity)
  end
  
  def stop
    @comm.close
  end
  
end
