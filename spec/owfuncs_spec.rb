require 'spec_helper'
require 'owfuncs'

describe OwFuncs do

	it "finds thermometers" do
		dir = ["1.thermo", "notathermo"]
		dir2 = ["1.thermo-temperature"]
		dir3 = ["1-thermo-temperature"]
		expect_any_instance_of( Onewire::Client ).to receive( :dir ).at_least(2).times.and_return( dir, dir2, dir3 )
		therms = OwFuncs.find_thermometers("test")
		expect(therms).to be_kind_of Array
		expect(therms.size).to eq(1)
	end

end