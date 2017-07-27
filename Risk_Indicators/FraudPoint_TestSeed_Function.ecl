import Models, Seed_Files;

export FraudPoint_TestSeed_Function(dataset(Layout_Input) inData, string20 TestDataTableName) := FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
		
	Models.Layouts.layout_fp1109 create_output(inData le, Seed_Files.Key_FraudPoint rt) := TRANSFORM
		reason_codes := dataset([
			{rt.hri,rt.hri_desc},
			{rt.hri2,rt.hri2_desc},
			{rt.hri3,rt.hri3_desc},
			{rt.hri4,rt.hri4_desc},
			{rt.hri5,rt.hri5_desc},
			{rt.hri6,rt.hri6_desc}
			], Layout_Desc);

		self.score := rt.score;
		self.ri := reason_codes( hri!='00' );
		self.seq := le.seq;
		self := rt;
		
	END;
	FraudPoint_rec := join(inData, Seed_Files.Key_FraudPoint,
														keyed(right.dataset_name=Test_Data_Table_Name) and 
														keyed(right.hashvalue=Seed_Files.Hash_InstantID(
															(string20)left.fname,
															(string20)left.lname,
															(string9)left.ssn,
															risk_indicators.nullstring,
															(string5)left.in_zipcode,
															(string10)left.phone10,
															risk_indicators.nullstring
														)),
														create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1)
													);

	return FraudPoint_rec;
END;