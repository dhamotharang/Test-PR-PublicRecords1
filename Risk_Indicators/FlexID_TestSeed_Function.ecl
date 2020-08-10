import iesp, Seed_Files, Address, Risk_Indicators, STD;

export FlexID_TestSeed_Function(dataset(iesp.flexid.t_FlexIdRequest) inData) := FUNCTION

	// if input name is in fullname field, then parse out before searching
	CleanName := Address.CleanPerson73(inData[1].searchby.name.full);
	
	iesp.flexid.t_FlexIDResult GetSeeds(inData le, Seed_files.Key_FlexID ri) := TRANSFORM
		self.VerifiedElementSummary := ri.VerifiedElementSummary;
		self.ValidElementSummary := ri.ValidElementSummary;
		self.VerifiedSSN := ri.verifiedSSN;
		self.inputecho := le.searchby;

		self := [];  
	END;
	seeds := join( inData, seed_files.Key_FlexID,
							KEYED((STD.Str.ToUpperCase(trim(left.user.TestDataTableName))=right.dataset_name)) and
							KEYED( Seed_Files.Hash_InstantID(
												(string20)(STD.Str.ToUpperCase(if(CleanName[6..25]<>'', CleanName[6..25],(LEFT.searchby.name.first)))),
												(string20)(STD.Str.ToUpperCase(if(CleanName[46..65]<>'', CleanName[46..65], (LEFT.searchby.name.last)))),
												(string)if(LENGTH(trim(LEFT.searchby.ssnlast4,all))=4 and LEFT.searchby.ssn = '', LEFT.searchby.ssnlast4,LEFT.searchby.ssn),
												risk_indicators.nullstring,
												(string5)(STD.Str.ToUpperCase((LEFT.searchby.address.zip5))),
												(string10)(STD.Str.ToUpperCase((LEFT.searchby.homephone))),
												risk_indicators.nullstring) = right.hashvalue ),
										GetSeeds(LEFT,RIGHT), left outer, keep(1)
									);	

	return seeds;

END;
