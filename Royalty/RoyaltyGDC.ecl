import IntlIID;

EXPORT RoyaltyGDC := MODULE
	
	EXPORT GetOnlineRoyalties(/*dataset(iesp.iid_international.t_InstantIDInternationalResponse_Unicode)*/dRecsOut) := 
	FUNCTIONMACRO
	
		dRoyal := project(dRecsOut, transform(Royalty.Layouts.Royalty,								
								iso2CC := IntlIID.IntlIIDFunctions().countryCodeISO2(left.Result.BillingCountry);
								self.royalty_type_code := Royalty.Functions.GetGDCRoyaltyCode(iso2CC);
								self.royalty_type 		 := Royalty.Functions.GetGDCRoyaltyType(iso2CC);
								self.royalty_count 		 := if(left.Result.IsBillable, 1, 0);
								self := []));
	
		dRoyalOut := rollup(sort(dRoyal, royalty_type_code), left.royalty_type_code = right.royalty_type_code,
									transform(Royalty.Layouts.Royalty, self.royalty_count := left.royalty_count + right.royalty_count; self := left;));	
			
		return dRoyalOut;
												
	ENDMACRO;		
	
	EXPORT GetOnlineRoyaltiesGG2(/*dataset(iesp.gg2_iid_intl.t_InstantIDIntl2Response)*/dRecsOut) := 
	FUNCTIONMACRO	
		
		import Gateway;
		
		dRoyal := project(dRecsOut, transform(Royalty.Layouts.Royalty,			
										self.royalty_type_code := Royalty.Functions.GetGG2RoyaltyCode(left.Result.BillingCountryCode);
										self.royalty_type 		 := Royalty.Functions.GetGG2RoyaltyType(left.Result.BillingCountryCode);
										self.royalty_count 		 := if(left.Result.IsBillable, 1, 0);
										self := [];										
									));		
		
		dRoyalOut := rollup(sort(dRoyal, royalty_type_code), left.royalty_type_code = right.royalty_type_code,
									transform(Royalty.Layouts.Royalty, self.royalty_count := left.royalty_count + right.royalty_count; self := left;));
		
		return dRoyalOut;
												
	ENDMACRO;		
		
END;