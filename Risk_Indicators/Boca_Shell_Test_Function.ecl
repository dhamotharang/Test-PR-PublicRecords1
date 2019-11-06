import Seed_Files,std, iesp;

export Boca_Shell_Test_Function(dataset(Risk_Indicators.Layout_Input) inData, string30 account_value, string20 TestDataTableName, boolean IsFCRA) := FUNCTION

	Test_Data_Table_Name := STD.Str.touppercase(TestDataTableName);
	
	keyName := Seed_Files.Key_Boca_Shell(IsFCRA);
	
	iesp.bocashelliss.t_BocaShellISS create_output(inData le, keyName ri) := transform
		self.seq := le.seq;	// make sure we use the input seq
		
		self := ri;
		self := le;
	END;
	hasher := Seed_Files.Hash_InstantID(
												(string15)indata[1].fname,
												(string20)indata[1].lname,
												(string9)indata[1].ssn,
												risk_indicators.nullstring,
												(string9)indata[1].in_zipcode,
												(string10)indata[1].phone10,
												risk_indicators.nullstring);
											
	BocaShellTestSeed := join(inData, keyName,
											keyed(right.dataset_name=Test_Data_Table_Name) and 
											keyed(right.hashvalue=hasher),
											create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1)
										);
	
	return BocaShellTestSeed;

END;
