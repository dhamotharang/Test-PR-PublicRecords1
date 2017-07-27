
IMPORT Seed_Files, Risk_Indicators;

EXPORT AMLRiskAttributesV2_TestSeed_Function(
	DATASET(Risk_Indicators.Layout_Input) inData,
	STRING20 TestDataTableName	) := FUNCTION
	
	Test_Data_Table_Name := StringLib.StringToUpperCase(TestDataTableName);


rAMLRAttributes := record
  Layouts.LayoutAMLShellV2;

END;	
	

	
	rAMLRAttributes create_outputV2(inData le, Seed_Files.key_AMLRiskAttributesV2 ri) := TRANSFORM
	   	SELF.seq 																					  := le.seq;
			SELF.IndHighValueAssets      							:=  ri.IndHighValueAssetsV2;
			SELF.IndAccesstoFunds         						:=  ri.IndAccessToFundsV2;
			SELF.IndGeographicRisk      							:=  ri.IndGeographicRiskV2;
			SELF.IndMobility    											:=  ri.IndMobilityV2;
			SELF.IndLegalEvents      									:=  ri.IndLegalEventsV2;
			SELF.IndHighRiskNewsProfiles          		:=  ri.IndHighRiskNewsProfilesV2;
			SELF.IndHighRiskNewsProfileType           :=  ri.IndHighRiskNewsProfileTypeV2;
			SELF.IndAgeRange              						:=  ri.IndAgeRangeV2;
			SELF.IndIdentityRisk                     :=  ri.IndIdentityRiskV2;
			SELF.IndResidencyRisk            				:=  ri.IndResidencyRiskV2;
			SELF.IndMatchLevel            					:=  ri.IndMatchLevelV2;
			SELF.IndPersonalAssocRisk            		:=  ri.IndPersonalAssocRiskV2;
			SELF.IndAssocResidencyRisk            	:=  ri.IndAssocResidencyRiskV2;
			SELF.IndProfessionalRisk            		:=  ri.IndProfessionalRiskV2;
			SELF.IndBusExecOffAssocRisk            :=  ri.IndBusExecOffAssocRiskV2;

	self := [];
	END;
	
	
	AMLRisk_Attr_recv2 := JOIN(inData, Seed_Files.key_AMLRiskAttributesV2, 
		KEYED(RIGHT.dataset_name = Test_Data_Table_Name)
		and KEYED(RIGHT.hashvalue = Seed_Files.Hash_InstantID((STRING20)LEFT.fname, (STRING20)LEFT.lname,
			(STRING9)LEFT.ssn, '', (STRING5)LEFT.in_zipCode, (STRING10)LEFT.phone10, '')),
		create_outputV2(LEFT,RIGHT), LEFT OUTER, ATMOST(100),KEEP(1));
		
AMLRiskAttrTest := 	 AMLRisk_Attr_recv2;	
// AMLRiskAttrTest := 	if(AttributesVersionRequest = 'AMLRINDVATTRV1', AMLRisk_Attr_rec, AMLRisk_Attr_recv2);	
		
	RETURN AMLRiskAttrTest;
END;