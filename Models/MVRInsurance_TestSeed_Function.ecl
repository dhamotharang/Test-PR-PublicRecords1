IMPORT iesp, Seed_Files, RiskWise, Risk_Indicators;

testSeedModelName := RECORD
	STRING10 model := '';
END;

EXPORT MVRInsurance_TestSeed_Function(DATASET(iesp.mvrinsurance.fcrainsurance.t_FcraInsuranceModelRequest) inData, STRING20 TestDataTableName, DATASET(testSeedModelName) modelNames) := FUNCTION
	Test_Data_Table_Name := StringLib.StringToUpperCase(TestDataTableName);
	models := SET(modelNames, model);
	
	Seed_Files.Layout_MVRInsurance createOutput(inData le, Seed_Files.Key_MVRInsurance ri) := TRANSFORM
		SELF.table_name := ri.table_name;
		SELF.model_name := ri.model_name;
		SELF.last := ri.last;
		SELF.first := ri.first;
		SELF.ssn := ri.ssn;
		SELF.zip5 := ri.zip5;
		SELF.score := ri.score;
	END;
	MVRInsuranceRecord := JOIN(inData, Seed_Files.Key_MVRInsurance, 
													KEYED(RIGHT.table_name = Test_Data_Table_Name) AND 
												  		KEYED(RIGHT.hashvalue = seed_files.Hash_InstantID(
																						StringLib.StringToUpperCase(TRIM(LEFT.SearchBy.Name.First)),
																						StringLib.StringToUpperCase(TRIM(LEFT.SearchBy.Name.last)),
																						StringLib.StringToUpperCase(TRIM(LEFT.SearchBy.ssn)),
																						Risk_Indicators.nullstring,                                                  // fein -- not used
																						StringLib.StringToUpperCase(TRIM(LEFT.SearchBy.Address.zip5)),
																						Risk_Indicators.nullstring,                                                  // phone -- not used
																						Risk_Indicators.nullstring                                                   // company_name -- not used
																						))
															AND KEYED(RIGHT.table_name = TestDataTableName)
															AND KEYED(RIGHT.model_name IN models),
													createOutput(LEFT,RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost));
	
	
	RETURN DEDUP(MVRInsuranceRecord, model_name);
END;