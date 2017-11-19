require 'onewire'
require './lib/config'
require './lib/thermometer'
require './lib/owfuncs'
require './lib/log_parser'

module GetTherms

  def self.get_therms
    therms = []
    host   = 'greenhousepi'

    $SCALE = :fahrenheit
    client = Onewire.client host
    thermsFound = OwFuncs.find_thermometers host

    thermsFound.each do |id|
	config = THERMOMETERS.select {|t| t[:id].match(/#{id}/)}[0]
	therm = Thermometer.new client, id
	therm.name = config.nil? ? "Therm-#{id}" : config[:name]
	therm.location = config.nil? ? "Location Unknown" : config[:location]
	therms << therm
    end
    therms
  end

  def self.daily_record( therm )
    parser = LogParser.new
    logs = parser.get_logs(:today)
    parser.min_max( logs, therm.name )
  end
    
  def self.yesterday_record( therm )
    parser = LogParser.new
    logs = parser.get_logs(:yesterday)
    parser.min_max( logs, therm.name )
  end
    
  def self.week_record( therm )
    parser = LogParser.new
    logs = parser.get_logs(:this_week)
    parser.min_max( logs, therm.name )
  end
    
  def self.month_record( therm )
    parser = LogParser.new
    logs = parser.get_logs(:this_month)
    parser.min_max( logs, therm.name )
  end
    
  def self.all_record( therm )
    parser = LogParser.new
    logs = parser.get_logs(:all)
    parser.min_max( logs, therm.name )
  end

end
