import Models, Seed_Files;

export RVAttributes_TestSeed_Function(dataset(Layout_Input) inData, string30 account_value, string20 TestDataTableName) := 
				
FUNCTION
	
	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	layout_rvAttrSeq := RECORD
		unsigned4 seq;
		Models.Layout_RVAttributes.RVAttributes;
	END;
	
	layout_rvAttrSeq create_output(inData le, Seed_Files.Key_RVAttributes ri) := TRANSFORM
		self.seq := le.seq;
		self.AccountNumber := account_value;
		self.lifestyle := ri.lifestyle;
		self.dems := ri.dems;
		self.finance := ri.finance;
		self.property := ri.property;
		self.derogs := ri.derogs;
		self.version2 := ri.version2;
		self.version3 := ri.version3;
		self := ri; 
	END;
	RiskView_rec := join(inData, Seed_Files.Key_RVAttributes,keyed(right.dataset_name=Test_Data_Table_Name) and 
												  keyed(right.hashvalue=Seed_Files.Hash_InstantID((string15)left.fname,(string20)left.lname,
														(string9)left.ssn,'',(string9)(left.z5+left.zip4),(string10)left.phone10,'')),
												create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1));
	
	
	return RiskView_rec;
END;