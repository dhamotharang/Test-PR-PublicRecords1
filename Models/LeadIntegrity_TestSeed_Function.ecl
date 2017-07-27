IMPORT Seed_Files, Risk_Indicators;

EXPORT LeadIntegrity_TestSeed_Function(
	DATASET(Risk_Indicators.Layout_Input) inData,
	STRING20 TestDataTableName,
	string modelname,
	unsigned1 version
	) := FUNCTION
	Test_Data_Table_Name := StringLib.StringToUpperCase(TestDataTableName);
	
	Models.layouts.Layout_LeadIntegrity_Attributes_Batch create_output(inData le, Seed_Files.Key_LeadIntegrityAttributes ri) := TRANSFORM
		SELF.seq := (STRING)le.seq;
		SELF.version4 := ri.version4;
		SELF.version3 := ri.version3;
		SELF := ri.version1;
		self.acctno := [];
	END;
	LeadIntegrityAttr_rec := JOIN(inData, Seed_Files.Key_LeadIntegrityAttributes, 
		KEYED(RIGHT.dataset_name = Test_Data_Table_Name)
		and KEYED(RIGHT.hashvalue = Seed_Files.Hash_InstantID((STRING15)LEFT.fname, (STRING20)LEFT.lname,
			(STRING9)LEFT.ssn, '', (STRING9)LEFT.in_zipCode, (STRING10)LEFT.phone10, ''))
		and (version < 4 /* starting with v4, we'll track the version on the testseed file */ or right.attributes_version = version)
		and trim(right.version1.scorename1) = StringLib.StringToUpperCase(trim(modelname)),
		create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1));

	RETURN LeadIntegrityAttr_rec;
END;