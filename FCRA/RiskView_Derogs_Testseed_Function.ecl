import risk_indicators, Seed_Files, riskwise;

export RiskView_Derogs_Testseed_Function(dataset(risk_indicators.Layout_Input) inData, string20 TestDataTableName) := FUNCTION
	
	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	fcra.riskview_derogs_module.batch_layout create_output(inData le, Seed_Files.Key_RVderogs rt) := TRANSFORM
		self := rt;
	END;
	
	RiskView_rec := join(inData, Seed_Files.Key_RVderogs,
				keyed(right.dataset_name=Test_Data_Table_Name) and 
				keyed(right.hashvalue=Seed_Files.Hash_InstantID((string15)left.fname,(string20)left.lname,
				(string9)left.ssn,'',(string9)(left.z5+left.zip4),(string10)left.phone10,'')),
				create_output(LEFT,RIGHT), atmost(riskwise.max_atmost));  // unlike other testseed functions, don't limit the result to 1, there can be more than 1 record per input
													
	return RiskView_rec;
	
END;