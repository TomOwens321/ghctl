require 'socket'

def send_msg( msg, client )
  puts "Sending #{msg} to #{client}"
  client.puts msg
end

server = TCPServer.new 3030

loop do
  Thread.start( server.accept ) do |client|
    loop do
      # do something
      if IO.select [client]
        msg = client.gets.chomp
        puts "#{msg} from #{client.inspect}"
      end
      send_msg( msg, client )
    end
  end
end