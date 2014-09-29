require 'spec_helper.rb'
require 'relay'

describe Relay do

	before( :each ) do
		@relay = Relay.new( 'client', 'scope' )
		@relay.location = 'PIO'
	end

	it "is a OneWire::Scope" do
		dir =  ["entry.one","entry.two"]
		expect_any_instance_of( Onewire::Scope ).to receive( :dir ).and_return( dir )
		expect( @relay.dir ).to eq( dir )
	end

	it "has a name" do
		name = "MyName"
		expect { @relay.name = name }.not_to raise_error
		expect( @relay.name ).to eq( name )
	end

	it "has a location" do
		location = "MyLocation"
		expect { @relay.location = location }.not_to raise_error
		expect( @relay.location ).to eq( location )
	end

	it "reports its state" do
		expect_any_instance_of( Onewire::Scope ).to receive( :read ).with( 'PIO' ).and_return( 0.0, 1.0 )
		expect( @relay.state ).to eq( :OFF )
		expect( @relay.state ).to eq( :ON )
	end

	it "raises when state is bad" do
		@relay.location = ''
		expect_any_instance_of( Onewire::Scope ).to receive( :read ).with( '' ).and_return( nil )
		expect { @relay.state }.to raise_error( /cannot be determined/i )
	end

	it "can set its state" do
		expect_any_instance_of( Onewire::Scope ).to receive( :write ).with( @relay.location, 1 ).and_return( nil )
		expect_any_instance_of( Onewire::Scope ).to receive( :write ).with( @relay.location, 0 ).and_return( nil )
		expect( @relay.state = :ON ).to eq( :ON )
		expect( @relay.state = :OFF ).to eq( :OFF )
		expect { @relay.state = :BAD }.to raise_error( /unknown state/i )
    end

end