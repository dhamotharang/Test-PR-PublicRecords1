IMPORT Seed_Files, Risk_Indicators;

EXPORT AMLRiskAttributes_TestSeed_Function(
	DATASET(Risk_Indicators.Layout_Input) inData,
	STRING20 TestDataTableName
	) := FUNCTION
	Test_Data_Table_Name := StringLib.StringToUpperCase(TestDataTableName);


rAMLRAttributes := record
  Risk_Indicators.Layout_Boca_Shell

END;	
	
	rAMLRAttributes create_output(inData le, Seed_Files.key_AMLRiskAttributes ri) := TRANSFORM
	SELF.seq 																					  := le.seq;
	SELF.AMLAttributes.IndCitizenshipIndex      				:=  ri.IndCitizenshipIndex;
	SELF.AMLAttributes.IndMobilityIndex         				:=  ri.IndMobilityIndex;
	SELF.AMLAttributes.IndLegalEventsIndex      				:=  ri.IndLegalEventsIndex;
	SELF.AMLAttributes.IndAccesstoFundsIndex    				:=  ri.IndAccesstoFundsIndex;
	SELF.AMLAttributes.IndBusinessAssocationIndex       :=  ri.IndBusinessAssocationIndex;
	SELF.AMLAttributes.IndHighValueAssetIndex           :=  ri.IndHighValueAssetIndex;
	SELF.AMLAttributes.IndGeographicIndex               :=  ri.IndGeographicIndex;
	SELF.AMLAttributes.IndAssociatesIndex               :=  ri.IndAssociatesIndex;
	SELF.AMLAttributes.IndAgeRange                      :=  ri.IndAgeRange;
	SELF.AMLAttributes.IndAMLNegativeNews90             :=  ri.IndAMLNegativeNews90;
  SELF.AMLAttributes.IndAMLNegativeNews24             :=  ri.IndAMLNegativeNews24;

	self := [];
	END;
	
	AMLRisk_Attr_rec := JOIN(inData, Seed_Files.key_AMLRiskAttributes, 
		KEYED(RIGHT.dataset_name = Test_Data_Table_Name)
		and KEYED(RIGHT.hashvalue = Seed_Files.Hash_InstantID((STRING20)LEFT.fname, (STRING20)LEFT.lname,
			(STRING9)LEFT.ssn, '', (STRING5)LEFT.in_zipCode, (STRING10)LEFT.phone10, '')),
		create_output(LEFT,RIGHT), LEFT OUTER, ATMOST(100),KEEP(1));
		
	RETURN AMLRisk_Attr_rec;
END;