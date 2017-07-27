import BadAddresses;

EXPORT getBadAddresses(DATASET(identifier2.layout_Identifier2) final_recs, 
																						string Verify_InputAddressMatchesKnownBad) := FUNCTION

knownBadAddr := BadAddresses.Keys().Key_address;

string25 actual_in_city := '' : stored('in_city');  // use the actual input city instead of one that gets updated by cleaner

//Define layout to be used in the project/transform below which formats the input strings to be compared against the customer test file.
	layout_ID2_plus_compField := Record
		string comparison_field;
		identifier2.layout_Identifier2;
	end;

//This section concerns formatting the input data which will be compared to the customer file.
	final_recs_plus_compField := project(final_recs, transform(layout_ID2_plus_compField,
		string address9	 := TRIM(stringlib.StringFilterOut((Stringlib.StringtoUpperCase(Left.in_streetAddress)), ' ')[1..9], left, right);
		City 			 			 := TRIM(Stringlib.StringtoUpperCase(actual_in_city), left, right);
		self.comparison_field := address9 + City;
		self := left));

//join to the known bad address file - initially FL DCF is the only customer on it (sourceid = '1')
	final_recs_plus_knownbad := if(trim(Verify_InputAddressMatchesKnownBad) = '1', //only search bad addresses for customers that provide them
		join(final_recs_plus_compField, knownBadAddr, 
			keyed(left.comparison_field=right.ADDRESS) and 
			right.sourceid = 1,
			transform(identifier2.layout_Identifier2, 
				self.InputAddressMatchesKnownBad := right.address <> '';
				self := left),	left outer, keep(1)),
			final_recs);

return final_recs_plus_knownbad;

end;