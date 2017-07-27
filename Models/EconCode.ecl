import Risk_Indicators;

export EconCode(string dwelltype, unsigned assessed_amount, Risk_Indicators.Layout_Address_AVM avm, unsigned census_value) := 
												
FUNCTION

	aptflag := trim(dwelltype) in ['A','H'];

	// calculate values for non-apartments
	econval := if(~aptflag, map( avm.avm_automated_valuation > 0 => avm.avm_automated_valuation,
															 assessed_amount > 0 => assessed_amount,
															 avm.avm_median_geo12_level > 0 => avm.avm_median_geo12_level,
															 avm.avm_median_geo11_level > 0 => avm.avm_median_geo11_level,
															 avm.avm_median_fips_level > 0 => avm.avm_median_fips_level,
															 census_value > 0 => census_value,
															 -1),
													-1);

	// calculate values for apartments
	aptval := if(aptflag, map(avm.avm_median_geo12_level > 0 => avm.avm_median_geo12_level,
														avm.avm_median_geo11_level > 0 => avm.avm_median_geo11_level,
														avm.avm_median_fips_level > 0 => avm.avm_median_fips_level,
														census_value > 0 => census_value,
														-1),
												-1);

	EconCode := if(~aptflag, map( econval > 650000 => 'A',
																econval > 450000 => 'B',
																econval > 250000 => 'C',
																econval > 125000 => 'D',
																econval >  75000 => 'E',
																econval >      0 => 'F',
																'U'),
													 map(	aptval > 1000000 => 'C',
																aptval >  500000 => 'D',
																aptval >  175000 => 'E',
																aptval >       0 => 'F',
																'U'));

	RETURN EconCode;

END;