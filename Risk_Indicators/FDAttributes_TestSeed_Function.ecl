import Models, Seed_Files;

export FDAttributes_TestSeed_Function(dataset(Layout_Input) inData, string30 account_value, string20 TestDataTableName) := 
				
FUNCTION
	
	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	
	Models.Layout_FraudAttributes create_output(inData le, Seed_Files.Key_FDAttributes ri) := TRANSFORM
		self.input := le;
		self.accountnumber := account_value;
		self.version1 := ri.version1;
		self.version2 := ri.version2;
		self.version201 := ri.version201;
		self.IDAttributes := ri.IDAttributes;
	END;
	FDtest := join(inData, Seed_Files.Key_FDAttributes,keyed(right.dataset_name=Test_Data_Table_Name) and 
												  keyed(right.hashvalue=Seed_Files.Hash_InstantID((string20)left.fname,(string20)left.lname,
																(string9)left.ssn,'',(string5)left.in_zipCode,(string10)left.phone10,'')),
												create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1));
	

	return FDtest;
END;