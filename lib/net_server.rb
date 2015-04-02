$:.unshift File.dirname(__FILE__), '.', 'lib'

require 'socket'
require 'command_parser'

def parse_msg( msg, client )
  response = CommandParser.parse msg
  client.puts response
  puts response
end

server = TCPServer.new 3030

loop do
  Thread.start( server.accept ) do |client|
    loop do
      # do something
      if IO.select [client]
        sleep 0.1
        msg = client.read_nonblock(1024)
        puts "#{msg} from #{client.inspect}"
      end
      parse_msg( msg, client )
    end
  end
end