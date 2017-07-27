import Seed_Files, Risk_Indicators;

export CAR_Test_Seed_Function(dataset(Risk_Indicators.Layout_Input) inData, string30 account_value, string20 TestDataTableName, boolean IsFCRA) := FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	keyName := Seed_Files.Key_Boca_Shell4(IsFCRA);
	
	Risk_Indicators.Layout_Boca_Shell create_output(inData le, keyName ri) := transform
		self.seq := le.seq;	// make sure we use the input seq
		
		self := ri;
		self := le;
		self := [];
	END;


	data16 hasher := Seed_Files.Hash_InstantID(
												(string15)indata[1].fname,
												(string20)indata[1].lname,
												(string9) indata[1].ssn,
												risk_indicators.nullstring,
												(string9) indata[1].in_zipCode,
												(string10)indata[1].phone10,
												risk_indicators.nullstring);
	BocaShellTestSeed := join(inData, keyName,
											keyed(right.dataset_name=Test_Data_Table_Name) and 
											keyed(right.hashvalue=hasher),
											create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1)
										);
	
	return BocaShellTestSeed;

END;
