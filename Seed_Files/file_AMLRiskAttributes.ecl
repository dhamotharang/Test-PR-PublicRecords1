IMPORT Data_Services,Seed_Files;

TestSeedLayout := record
  string20 dataset_name;
	string30 Formatted_Cust	;
	string10 CustTypeCD	;
	string20 FIRST_NM	;
	string20 LAST_NM	;
	string120 Business_Name;
	string5 	zip	;
	string10 	Phone	;
	string9 Individual_TIN	;
	string9 Business_TIN	;
	STRING2 IndCitizenshipIndex;
	STRING2 IndMobilityIndex;
	STRING2 IndLegalEventsIndex;
	STRING2 IndAccesstoFundsIndex;
	STRING2 IndBusinessAssocationIndex;
	STRING2 IndHighValueAssetIndex;
	STRING2 IndGeographicIndex;
	STRING2 IndAssociatesIndex;
	STRING2 IndAgeRange;
	STRING3 IndAMLNegativeNews90;
  STRING3 IndAMLNegativeNews24;

	STRING2 BusValidityIndex;
	STRING2 BusStabilityIndex;
	STRING2 BusLegalEventsIndex;
	STRING2 BusAccesstoFundsIndex;
	STRING2 BusGeographicIndex;
	STRING2 BusAssociatesIndex;
	STRING2 BusIndustryRiskIndex;
	STRING3 BusAMLNegativeNews90;
  STRING3 BusAMLNegativeNews24;
END;

//Please rename the input file appropriately
EXPORT file_AMLRiskAttributes := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_amlriskattributes', TestSeedLayout, CSV(HEADING(single), QUOTE('"')));
