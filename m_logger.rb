require 'socket'
require 'yaml'

HOST = 'ghpi'
PORT = 3030
ARDUINO = 'My Arduino'

@conn = TCPSocket.new HOST, PORT

def sendCmd( cmd )
  @conn.puts cmd.to_yaml
end

def recvRslt
  #puts "Getting result"
  if IO.select([@conn])
    sleep 0.2
    yml = @conn.read_nonblock(1024)
  end
  result = YAML.load yml
end

def get_devices
  h = "devices"
  sendCmd h
  result = recvRslt
end

def get_message
  #puts "Getting message"
  h = {device: ARDUINO, cmd: :get_message}
  sendCmd h
  result = recvRslt
end

def get_status
  #puts "Getting status"
  h = {device: ARDUINO, cmd: :status}
  sendCmd h
  result = recvRslt
end

def timestamp
  Time.now.strftime "[%m-%d-%Y %H:%M:%S]"
end

devs = get_devices
puts "#{devs}"

delay = 5
count = 0
loop do
  
  msg = get_message
  msg.each_line {|line| puts "#{timestamp} #{line}"}
  
  if count >= 60 || count == 0
    stat = get_status
    stat.each_line {|line| puts "#{timestamp} #{line}"}
    count = 0
  end
  
  count += delay
  sleep delay
end
puts get_message
puts get_status
