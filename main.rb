#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

require 'device'

Dir['./lib/devices_available/*'].each {|file| require file}

load 'net_server.rb'