// PRTE2_PropertyInfo.Files
IMPORT PRTE2_Common;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	
	EXPORT GATEWAY_NAME						:= 'gateway_PII';
	EXPORT GATEWAY_SCRAMBLE				:= 'gateway_PII_scramble';
	EXPORT SCRAMBLE_NAME					:= 'New_Alpharetta_base';
	EXPORT NewData_Suffix					:= 'Alpha_Base_Add_records';
	EXPORT Alpha_MV_Suffix 				:= 'Alpha_MV_base';
	EXPORT IN_PREFIX_NAME					:= '~prct::IN::ct::propertyinfo';
	EXPORT BASE_PREFIX_NAME				:= '~prct::BASE::ct::propertyinfo';
	EXPORT MV_BASE_PREFIX_NAME		:= '~prct::MVBASE::ct::propertyinfo';
	EXPORT SCRAMBLE_PREFIX_NAME		:= '~prct::SCRAMBLE::ct::propertyinfo';
	EXPORT SPRAYED_PREFIX_NAME    := '~prct::SPRAYED::ct::propertyinfo';
	EXPORT KEY_PREFIX_NAME				:= '~prte::key::propertyinfo::';
	
	EXPORT PII_CSV_FILE						:= IN_PREFIX_NAME + '::CSV::' + GATEWAY_NAME;
	// ORIGINAL GATEWAY FILE (NOTE: Possibly in the bad C1..C85 layout) requires Transform_data to convert
	EXPORT FILE_SPRAY							:= SPRAYED_PREFIX_NAME + '::'+GATEWAY_NAME+ '_' + ThorLib.Wuid();
	EXPORT SPRAYED_DS							:= DATASET(FILE_SPRAY, Layouts.batch_in,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// New NANCY Spreadsheet layout matches Boca Base file layout
	EXPORT SCRAMBLE_SPRAY					:= SPRAYED_PREFIX_NAME + '::'+SCRAMBLE_NAME+ '_' + ThorLib.Wuid();
	EXPORT SCRAMBLE_SPRAY_DS			:= DATASET(SCRAMBLE_SPRAY, Layouts.AlphaPropertyCSVRec,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	// Extra scramble names and DS for research/data repairs
	EXPORT SCRAMBLE_SPRAY1				:= SPRAYED_PREFIX_NAME + '::'+SCRAMBLE_NAME+ '_1_' + ThorLib.Wuid();
	EXPORT SCRAMBLE_SPRAY2				:= SPRAYED_PREFIX_NAME + '::'+SCRAMBLE_NAME+ '_2_' + ThorLib.Wuid();
	EXPORT SCRAMBLE_SPRAY_DS1			:= DATASET(SCRAMBLE_SPRAY1, Layouts.AlphaPropertyCSVRec,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	EXPORT SCRAMBLE_SPRAY_DS2			:= DATASET(SCRAMBLE_SPRAY2, Layouts.AlphaPropertyCSVRec,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// LCAIN300 - Old 300 test cases Linda did
	EXPORT Linda_PII_Scrambled    := '~prte::in::custtest::csv::scrambled::propertyinfo9b';
	EXPORT Linda_Scrambled_DS 		:= DATASET(Linda_PII_Scrambled,	layouts.batch_in,
																		 CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));

	// This is the full Property Info in early form as it came from the gateway (Alpharetta only)
	EXPORT PII_Gateway_Base_SF					:= BASE_PREFIX_NAME + '::qa::' + GATEWAY_NAME;
	EXPORT PII_Gateway_Base_SF_DS				:= DATASET(PII_Gateway_Base_SF, Layouts.batch_in, THOR);


	// This is the alpharetta "Base" ... This is the PII base file, it's also scrambled.
	EXPORT PII_ALPHA_BASE_SF						:= BASE_PREFIX_NAME + '::qa::' + SCRAMBLE_NAME;
	EXPORT PII_ALPHA_BASE_SF_DS					:= DATASET(PII_ALPHA_BASE_SF, Layouts.AlphaPropertyCSVRec, THOR);

	EXPORT ALPHA_MV_BASE_SF						:= BASE_PREFIX_NAME +'::'+ Alpha_MV_Suffix;
	EXPORT ALPHA_MV_BASE_DS						:= DATASET(ALPHA_MV_BASE_SF, Layouts_MV.MV_Base_Layout, THOR);

	EXPORT PropInfo_New_Subfile					:= IN_PREFIX_NAME+'::QA::'+NewData_Suffix;
	EXPORT PropInfo_New_Sub_DS					:= DATASET(PropInfo_New_Subfile, Layouts.AlphaPropertyCSVRec, THOR);
	
	// EXPORT BOCA_BASE_SF_DS							:= DATASET([], Layouts.AlphaPropertyCSVRec);

	// ****************************************************************************************************
	// These are here just for auditing - get_Payload does a persist to this name during the build.
	// It should be in the same layout as the base file, simply has recalculated clean addresses in it.
	EXPORT NewAlphaExpandedName 		:= '~prte::ct::propertyinfo::audit::newexpanded_Alpha';
	EXPORT NewAlphaExpandedDS				:= DATASET(NewAlphaExpandedName, Layouts.AlphaPropertyCSVRec, THOR);
	// Can these be switched to ~prct ?? or are there dependancies? are these base, should we use a base name?
	// More auditing files NEW_process_build_propertyinfo does an OUTPUT(,,Overwrite) to these
	EXPORT Build_Existing_PII_OutputName := '~prte::ct::propertyinfo::join::expanded';
	EXPORT Build_Old_PII_OutputName_DS	:= DATASET(Build_Existing_PII_OutputName, Layouts.Boca_Official_Layout, THOR);
	EXPORT Build_New_PII_OutputName := '~prte::ct::propertyinfo::join::newexpanded';
	EXPORT Build_New_PII_OutputName_DS	:= DATASET(Build_New_PII_OutputName, Layouts.Boca_Official_Layout, THOR);
	EXPORT Build_ALL_PII_OutputName := '~prte::ct::propertyinfo::join::ALLexpanded';
	EXPORT Build_ALL_PII_OutputName_DS	:= DATASET(Build_ALL_PII_OutputName, Layouts.Boca_Official_Layout, THOR);
	
	EXPORT STRING BuildKeyRIDName(STRING version) := KEY_PREFIX_NAME + version + '::rid';
	EXPORT STRING BuildKeyADDRName(STRING version) := KEY_PREFIX_NAME + version + '::address';
	// There are no SF's surrounding the logical CT files in Boca

	
	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT STRING BuildKeyRIDNameProd(STRING version) := Add_Foreign_prod(BuildKeyRIDName(version));
	EXPORT STRING BuildKeyADDRNameProd(STRING version) := Add_Foreign_prod(BuildKeyADDRName(version));
	EXPORT PII_ALPHA_BASE_SF_Prod				:= Add_Foreign_prod(PII_ALPHA_BASE_SF);
	EXPORT PII_ALPHA_BASE_SF_DS_Prod		:= DATASET(PII_ALPHA_BASE_SF_Prod, Layouts.AlphaPropertyCSVRec, THOR);
	
	
	// EXPORT BOCA_BASE_SF_NAME_PROD				:= Add_Foreign_prod(BOCA_BASE_SF_NAME);
	// EXPORT BOCA_BASE_SF_DS_PROD					:= DATASET(BOCA_BASE_SF_NAME_PROD, Layouts.AlphaPropertyCSVRec, THOR);
	EXPORT Linda_PII_Scrambled_Prod := Add_Foreign_prod('~prte::in::custtest::csv::scrambled::propertyinfo9b');
	EXPORT Linda_Scrambled_DS_Prod 	:= DATASET(Linda_PII_Scrambled_Prod,	layouts.batch_in,
																		 CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
END;