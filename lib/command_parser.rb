$:.unshift File.dirname(__FILE__), '.', 'lib'

require 'yaml'
require 'owfuncs'

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
    case command.downcase
    when "hello"
      return "Hello to you too"
    when "thermometers"
      return OwFuncs.find_thermometers( 'localhost' )
    else
      return "Unable to process #{command}"
    end
  end

end