IMPORT Seed_Files, business_risk;

EXPORT AMLRiskAttributes_BusnTestSeed_Function(
	DATASET(business_risk.Layout_Input) inData,
	STRING20 TestDataTableName
	) := FUNCTION
	Test_Data_Table_Name := StringLib.StringToUpperCase(TestDataTableName);
	


rAMLRAttributesBusn := record
  Layouts.AMLBusnAssocLayout;
END;	
	
	rAMLRAttributesBusn create_output(inData le, Seed_Files.key_AMLRiskAttributesBusn ri) := TRANSFORM
	SELF.seq 															 := le.seq;
	SELF.BusValidityIndex                  := ri.BusValidityIndex;
	SELF.BusStabilityIndex                 := ri.BusStabilityIndex;
	SELF.BusLegalEventsIndex               := ri.BusLegalEventsIndex;
	SELF.BusAccesstoFundsIndex             := ri.BusAccesstoFundsIndex;
	SELF.BusGeographicIndex                := ri.BusGeographicIndex;
	SELF.BusAssociatesIndex                := ri.BusAssociatesIndex;
	SELF.BusIndustryRiskIndex              := ri.BusIndustryRiskIndex;
	SELF.BusAMLNegativeNews90              := ri.BusAMLNegativeNews90;
  SELF.BusAMLNegativeNews24              :=	ri.BusAMLNegativeNews24;
	SELF 														       := [];
	END;
	
	AMLRiskBusn_Attr_rec := JOIN(inData, Seed_Files.key_AMLRiskAttributesBusn, 
		KEYED(RIGHT.dataset_name = Test_Data_Table_Name)
		and KEYED(RIGHT.hashvalue = Seed_Files.Hash_InstantID('', '',
			'', left.fein, (STRING5)LEFT.z5, (STRING10)LEFT.phone10, left.company_name)),
		create_output(LEFT,RIGHT), LEFT OUTER, ATMOST(100),KEEP(1));
		
	RETURN AMLRiskBusn_Attr_rec;
END;