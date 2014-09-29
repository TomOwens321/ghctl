require 'spec_helper.rb'
require 'thermometer'

describe Thermometer do 

  before( :each ) do
  	@th = Thermometer.new('client', 'path')
  	@dir = ["entry.one","entry.two"]
  end

  it "is a Onewire::Scope" do
  	expect_any_instance_of(Onewire::Scope).to receive(:dir).and_return(@dir)
  	expect( @th.dir ).to eq( @dir )
  end

  it "knows the temperature" do
  	expect_any_instance_of(Onewire::Scope).to receive(:read).with('temperature').and_return(25)
  	expect(@th.temperature).to eq(25)
  end

  it "has a name" do
  	name = "MyName"
  	expect {@th.name = name}.not_to raise_error
  	expect( @th.name ).to eq( name )
  end

  it "has a location" do
  	location = "MyLocation"
  	expect {@th.location = location}.not_to raise_error
  	expect( @th.location ).to eq( location )
  end

  it "sets the highTemp alarm" do
  	highTemp = 25
  	expect_any_instance_of(Onewire::Scope).to receive(:write).with('temphigh', highTemp)
  	expect_any_instance_of(Onewire::Scope).to receive(:read).with('temphigh').and_return(highTemp)
  	
  	expect {@th.highTempAlarm = highTemp}.not_to raise_error
  	expect( @th.highTempAlarm ).to eq( highTemp )
  end

  it "sets the lowTemp alarm" do
  	lowTemp = 25
  	expect_any_instance_of(Onewire::Scope).to receive(:write).with('templow', lowTemp)
  	expect_any_instance_of(Onewire::Scope).to receive(:read).with('templow').and_return(lowTemp)
  	expect {@th.lowTempAlarm = lowTemp}.not_to raise_error
  	expect( @th.lowTempAlarm ).to eq( lowTemp )
  end
	
end