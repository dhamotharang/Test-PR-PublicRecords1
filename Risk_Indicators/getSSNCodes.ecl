import riskwise,address;

export getSSNCodes(dataset(RiskWise.layouts.layout_ssn_in) indata, boolean isFCRA=false) := function
	
	// make codes_in a filtered dataset of only records that have social present on input 
	// to avoid running all of this code on empty socials
	good_indata := indata(trim(ssn)<>'');
	codes_out := Risk_Indicators.SSNCodes( good_indata, isFCRA );

	riskwise.layout_socl formatOutdata(good_indata le, codes_out rt) := TRANSFORM
		self.seq := le.seq;	
		self.socscode := (string)rt.ssncode;
		self.dobcode  := (string)rt.dobcode;
			
		// agenow, lowage, and highage are not calculated at this time, as they are not used in any of our code
		self := rt;
	end;

	populated_socials := join(good_indata, codes_out, left.seq=right.seq, formatOutdata(left,right), left outer);
	empty_socials := project(indata(trim(ssn)=''), transform(riskwise.layout_socl, self.seq := left.seq, self := []) );

	final := ungroup(populated_socials + empty_socials);
	
	return final;
end;