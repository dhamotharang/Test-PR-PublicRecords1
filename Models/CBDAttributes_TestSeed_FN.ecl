import Seed_Files, Risk_Indicators;

export CBDAttributes_TestSeed_FN(dataset(Risk_Indicators.Layout_BocaShell_BtSt.BTST_input) inData, string30 account_value, string20 TestDataTableName) := FUNCTION
	
	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	
	Models.Layout_CBDAttributes create_output(inData le, Seed_Files.Key_CBDAttributes ri) := TRANSFORM
		self.seq := le.seq;
		self.AccountNumber := account_value;
		self.identityv1 := ri.identityv1;
		self.relationshipv1 := ri.relationshipv1;

		self.identityv4 := ri.identityv4;
		self.relationshipv4 := ri.relationshipv4;
		self.velocityv4 := ri.velocityv4;


	END;
	cbdAttr_rec := join(inData, Seed_Files.Key_CBDAttributes,keyed(right.dataset_name=Test_Data_Table_Name) and 
												  keyed(right.hashvalue=Seed_Files.Hash_InstantID((string15)left.fname,(string20)left.lname,
														(string9)left.ssn,'',(string9)(left.z5),(string10)left.phone10,'')),
												create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1));
	
	
	return cbdAttr_rec;
END;