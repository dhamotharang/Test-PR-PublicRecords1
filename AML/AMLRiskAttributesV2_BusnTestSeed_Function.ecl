IMPORT Seed_Files, business_risk;

EXPORT AMLRiskAttributesV2_BusnTestSeed_Function(
	DATASET(business_risk.Layout_Input) inData,
	STRING20 TestDataTableName
	) := FUNCTION
	Test_Data_Table_Name := StringLib.StringToUpperCase(TestDataTableName);
	


rAMLRAttributesBusn := record
  Layouts.BusnLayoutV2;
END;	
	
	rAMLRAttributesBusn create_output(inData le, Seed_Files.key_AMLRiskAttributesBusnV2 ri) := TRANSFORM
	SELF.seq 														:= le.seq;
	SELF.BusHighValueAssets    					:= ri.BusHighValueAssetsV2;
	SELF.BusAccessToFunds        				:= ri.BusAccessToFundsV2;
	SELF.BusGeographicRisk      				:= ri.BusGeographicRiskV2;
	SELF.BusValidityRisk     						:= ri.BusValidityRiskV2;
	SELF.BusStabilityRisk     					:= ri.BusStabilityRiskV2;
	SELF.BusIndustryRisk      					:= ri.BusIndustryRiskV2;
	SELF.BusShellShelfRisk        			:= ri.BusShellShelfRiskV2;
	SELF.BusStructureType       				:= ri.BusStructureTypeV2;
	SELF.BusSOSAgeRange         				:= ri.BusSOSAgeRangeV2;
	SELF.BusPublicRecordAgeRange   			:= ri.BusPublicRecordAgeRangeV2;
	SELF.BusMatchLevel          				:= ri.BusMatchLevelV2;
	SELF.BusLegalEvents                := ri.BusLegalEventsV2;
	SELF.BusHighRiskNewsProfiles       := ri.BusHighRiskNewsProfilesV2;
	SELF.BusHighRiskNewsProfileType    := ri.BusHighRiskNewsProfileTypeV2;
	SELF.BusLinkedBusRisk           		:= ri.BusLinkedBusRiskV2;
	SELF.BusExecOfficersRisk        		:= ri.BusExecOfficersRiskV2;
	SELF.BusExecOfficersResidencyRisk    := ri.BusExecOfficersResidencyRiskV2;
	SELF 														       := [];
	END;
	
	AMLRiskBusn_Attr_rec := JOIN(inData, Seed_Files.key_AMLRiskAttributesBusnV2, 
		KEYED(RIGHT.dataset_name = Test_Data_Table_Name)
		and KEYED(RIGHT.hashvalue = Seed_Files.Hash_InstantID('', '',
			'', left.fein, (STRING5)LEFT.z5, (STRING10)LEFT.phone10, left.company_name)),
		create_output(LEFT,RIGHT), LEFT OUTER, ATMOST(100),KEEP(1));
		
	RETURN AMLRiskBusn_Attr_rec;
END;