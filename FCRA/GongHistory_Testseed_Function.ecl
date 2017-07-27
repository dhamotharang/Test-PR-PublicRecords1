import risk_indicators, Seed_Files, riskwise;

export GongHistory_Testseed_Function(dataset(risk_indicators.Layout_Input) inData, string20 TestDataTableName) := FUNCTION
	
	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	fcra.GongHistoryLayouts.Layout_GongHistoryFCRA create_output(inData le, Seed_Files.Key_FCRA_GongHistory rt) := TRANSFORM
		self := rt;
	END;
	
	GongHistory_rec := join(inData, Seed_Files.Key_FCRA_GongHistory,
				keyed(right.dataset_name=Test_Data_Table_Name) and 
				keyed(right.hashvalue=Seed_Files.Hash_InstantID((string15)left.fname,(string20)left.lname,
				(string9)left.ssn,'',(string9)(left.z5+left.zip4),(string10)left.phone10,'')),
				create_output(LEFT,RIGHT), atmost(riskwise.max_atmost));  // unlike other testseed functions, don't limit the result to 1, there can be more than 1 record per input

	return GongHistory_rec;
	
END;