require 'socket'
require 'yaml'

def cmd(conn, cmd)
  conn.puts cmd.to_yaml if IO.select( nil, [conn], nil, 1)
  begin
    result = conn.read_nonblock(2048) if IO.select([conn])
  rescue Exception => e
    p e
  end
  result
end

def set_ref(table,value)
  parm = "#{table} #{value}"
end

conn = TCPSocket.new 'ghpi', 3030
duinoStat = {device: 'My Arduino', cmd: :status}
thermo = {device: 1, cmd: :temperature}
newRef = {device: 'My Arduino', cmd: :set_reference, params: set_ref(0,512)}
newRef1 = {device: 'My Arduino', cmd: :set_reference, params: set_ref(1,520)}
devices = 'devices'

r = cmd(conn,devices)
p YAML.load r
r = cmd(conn,duinoStat)
p YAML.load r
r = cmd(conn,thermo)
p YAML.load r
r = cmd(conn,newRef)
p YAML.load r
r = cmd(conn,newRef1)
p YAML.load r
r = cmd(conn,duinoStat)
p YAML.load r
