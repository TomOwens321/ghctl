$:.unshift File.dirname(__FILE__), '.', 'lib', 'lib/devices'

require 'yaml'
require 'device'

module CommandParser

  def CommandParser.parse( msg )
    begin
      cmd = YAML.load msg
    rescue
      return "Unable to parse message: #{msg}".to_yaml
    end
    return CommandParser.do_command( cmd ).to_yaml
  end

  def CommandParser.do_command( command )
    puts "do_commanding #{command}"
    #cmd = eval( command )
    p command.class
    case command.to_s.downcase
    when "hello"
      return "Hello to you too"
    when "devices"
      return Device.devices
    when "arduinos"
      return Device.devices.select {|dev| dev.include? "Arduino"}
    when "thermometers"
      return Device.devices.select {|dev| dev.include? "Thermometer"}
    else
      #return "Unable to process #{command}"
      CommandParser.command( command )
    end
  end

  def CommandParser.command( cmd )
    return "No target device in cmd!" if cmd[:device].nil?
    dev = Device.connect(cmd[:device])
    return "Cannot connect to device #{cmd[:device].to_s}" if dev.nil?
    begin
      if cmd[:params].nil?
        result = dev.send(cmd[:cmd])
      else
        result = dev.send(cmd[:cmd], *[cmd[:params]])
      end
    rescue StandardError => e
      result = e.message
    end
    return result
  end

end