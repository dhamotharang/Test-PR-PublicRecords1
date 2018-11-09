// PRTE2_PropertyInfo.Files
IMPORT PRTE2_Common;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	
	EXPORT GATEWAY_NAME						:= 'gateway_PII';
	EXPORT GATEWAY_SCRAMBLE				:= 'gateway_PII_scramble';
	EXPORT SCRAMBLE_NAME					:= 'New_Alpharetta_base';
	
	EXPORT IN_PREFIX_NAME					:= '~prct::IN::ct::propertyinfo';
	EXPORT BASE_PREFIX_NAME				:= '~prct::BASE::ct::propertyinfo';
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
	EXPORT SCRAMBLE_SPRAY_DS			:= DATASET(SCRAMBLE_SPRAY, Layouts.PropertyExpandedRec,
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
	EXPORT PII_ALPHA_BASE_SF_DS					:= DATASET(PII_ALPHA_BASE_SF, Layouts.PropertyExpandedRec, THOR);
	
	EXPORT BOCA_BASE_SUFFIX							:= 'keys_Base_Boca';
	EXPORT BOCA_BASE_PERM_SUFFIX				:= 'PERM_SAVE::'+BOCA_BASE_SUFFIX;
	EXPORT BOCA_SPRAY_NAME							:= SPRAYED_PREFIX_NAME + '::'+BOCA_BASE_SUFFIX+ '_' + ThorLib.Wuid();
	EXPORT BOCA_SPRAY_DS								:= DATASET(BOCA_SPRAY_NAME, Layouts.PropertyExpandedRec,
																							CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	EXPORT BOCA_BASE_SF_NAME						:= BASE_PREFIX_NAME + '::qa::' + BOCA_BASE_PERM_SUFFIX;
	EXPORT BOCA_BASE_SF_DS							:= DATASET(BOCA_BASE_SF_NAME, Layouts.PropertyExpandedRec, THOR);
	EXPORT BOCA_SAVE_LAST_COPY_NAME			:= Add_Foreign_prod('~prct::BASE::ct::propertyinfo::ALPHA_OLDEST_LAST_COPY');
	EXPORT BOCA_SAVE_LAST_COPY_DS				:= DATASET(BOCA_SAVE_LAST_COPY_NAME, Layouts.PropertyExpandedRec, THOR);
	/*  NOTE: See also: PRTE2_PropertyInfo.U_ZAP_BOCA_BASE in Dev repository
			BOCA_SAVE_LAST_COPY_DS was saved because the Boca Base file was not Boca data - it was early alpharetta data
			that Linda Cain created which someone then moved into a CSV in EData12 which Linda could not get to
			So Linda created a small 300 test case additional file to add to that CSV which TOTALLY confused me
			I thought it was a Boca Base.   ***SO*** we are duplicating much of that data twice.
			We will zero out the Boca data file and leave it there for Boca to begin using if they want to add data into this PRTE query.  */			
			
	// These are here just for auditing - get_Payload does a persist to this name during the build.
	// It should be in the same layout as the base file, simply has recalculated clean addresses in it.
	EXPORT NewAlphaExpandedName 		:= '~prte::ct::propertyinfo::audit::newexpanded_Alpha';
	EXPORT NewAlphaExpandedDS				:= DATASET(NewAlphaExpandedName, Layouts.PropertyExpandedRec, THOR);
	// Can these be switched to ~prct ?? or are there dependancies? are these base, should we use a base name?
	// More auditing files NEW_process_build_propertyinfo does an OUTPUT(,,Overwrite) to these
	EXPORT Build_Existing_PII_OutputName := '~prte::ct::propertyinfo::join::expanded';
	EXPORT Build_Old_PII_OutputName_DS	:= DATASET(Build_Existing_PII_OutputName, Layouts.PC_Base_Layout, THOR);
	EXPORT Build_New_PII_OutputName := '~prte::ct::propertyinfo::join::newexpanded';
	EXPORT Build_New_PII_OutputName_DS	:= DATASET(Build_New_PII_OutputName, Layouts.PC_Base_Layout, THOR);
	EXPORT Build_ALL_PII_OutputName := '~prte::ct::propertyinfo::join::ALLexpanded';
	EXPORT Build_ALL_PII_OutputName_DS	:= DATASET(Build_ALL_PII_OutputName, Layouts.PC_Base_Layout, THOR);
	
	EXPORT STRING BuildKeyRIDName(STRING version) := KEY_PREFIX_NAME + version + '::rid';
	EXPORT STRING BuildKeyADDRName(STRING version) := KEY_PREFIX_NAME + version + '::address';
	// There are no SF's surrounding the logical CT files in Boca

	
	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT STRING BuildKeyRIDNameProd(STRING version) := Add_Foreign_prod(BuildKeyRIDName(version));
	EXPORT STRING BuildKeyADDRNameProd(STRING version) := Add_Foreign_prod(BuildKeyADDRName(version));
	EXPORT PII_ALPHA_BASE_SF_Prod				:= Add_Foreign_prod(PII_ALPHA_BASE_SF);
	EXPORT PII_ALPHA_BASE_SF_DS_Prod		:= DATASET(PII_ALPHA_BASE_SF_Prod, Layouts.PropertyExpandedRec, THOR);
	EXPORT BOCA_BASE_SF_NAME_PROD				:= Add_Foreign_prod(BOCA_BASE_SF_NAME);
	EXPORT BOCA_BASE_SF_DS_PROD					:= DATASET(BOCA_BASE_SF_NAME_PROD, Layouts.PropertyExpandedRec, THOR);
	EXPORT Linda_PII_Scrambled_Prod := Add_Foreign_prod('~prte::in::custtest::csv::scrambled::propertyinfo9b');
	EXPORT Linda_Scrambled_DS_Prod 	:= DATASET(Linda_PII_Scrambled_Prod,	layouts.batch_in,
																		 CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
END;