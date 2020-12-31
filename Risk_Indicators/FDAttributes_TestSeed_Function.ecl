﻿import Models, Seed_Files, STD, Risk_Indicators;

export FDAttributes_TestSeed_Function(dataset(Risk_Indicators.Layout_Input) inData, string30 account_value, string20 TestDataTableName) := FUNCTION
	
	Test_Data_Table_Name := Std.Str.ToUppercase(TestDataTableName);
	
	Models.Layout_FraudAttributes create_output(inData le, Seed_Files.Key_FDAttributes ri) := TRANSFORM
    
    self.input.DID := if(le.fname <> '', Risk_Indicators.iid_constants.fn_CreateFakeDID((string)le.fname, (string)le.lname), 0);
    self.input := le;
    self.accountnumber := account_value;
    self.version1 := ri.version1;
    self.version2 := ri.version2;
    self.version201 := ri.version201;
    self.version202 := ri.version202;
    self.IDAttributes := ri.IDAttributes;
    self.ParoAttributes := ri.ParoAttributes;
    self.ThreatMetrix := ri.Threatmetrix; 
    self.compromisedDL_hash := '';  // we don't need to log this for testseed transactions
	END;
	FDtest := join(inData, Seed_Files.Key_FDAttributes,keyed(right.dataset_name=Test_Data_Table_Name) and 
												  keyed(right.hashvalue=Seed_Files.Hash_InstantID((string20)left.fname,(string20)left.lname,
																(string9)left.ssn,'',(string5)left.in_zipCode,(string10)left.phone10,'')),
												create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1));
	
	return FDtest;
END;