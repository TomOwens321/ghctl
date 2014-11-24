#!/usr/bin/env ruby
require './mod_therms.rb'

hdr = "Content-Type: text/html\n\n"
hdr += "<!DOCTYPE html>\n"
hdr += "<HTML><HEAD>\n"
hdr += "<TITLE>Hello World</TITLE></HEAD>\n"
hdr += "<BODY>\n"
ftr = "</BODY></HTML>\n"
hi = "Hello World!"

def thermo_div( therm )
  daily = GetTherms.daily_record( therm )
  yesterday = GetTherms.yesterday_record( therm )
  week = GetTherms.week_record( therm )
  month = GetTherms.month_record( therm )
  div = "<div class='thermodiv'>"
  div += "<table class='thermotable' border='1'>"
  div += "<tr><th colspan='3'> #{therm.name} </th></tr>"
  div += "<tr><td colspan='3'> #{therm.temperature} </td></tr>"
  div += "<tr><th>Period</th><th>High</th><th>Low</th></tr>"
  div += "<tr><td>Day</td><td>#{daily[:max]}</td><td>#{daily[:min]}</td></tr>"
  div += "<tr><td>Yesterday</td><td>#{yesterday[:max]}</td><td>#{yesterday[:min]}</td></tr>"
  div += "<tr><td>Week</td><td>#{week[:max]}</td><td>#{week[:min]}</td></tr>"
  div += "<tr><td>Month</td><td>#{month[:max]}</td><td>#{month[:min]}</td></tr>"
  div += "</table></div>"
  div
end
therms = GetTherms.get_therms
puts hdr
puts "Ruby says #{hi}\n"
therms.each do |therm|
  puts "#{thermo_div(therm)}"
end
puts ftr
