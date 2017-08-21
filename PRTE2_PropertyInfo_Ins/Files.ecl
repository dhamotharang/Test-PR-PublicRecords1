// PRTE2_PropertyInfo_Ins.Files
IMPORT PRTE2_Common;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	
	EXPORT ALPHA_Base_Name				:= 'New_Alpharetta_base';
	EXPORT NewData_Suffix					:= 'Alpha_Base_Add_records';
	EXPORT Alpha_MV_Suffix 				:= 'Alpha_MV_base';
	EXPORT IN_PREFIX_NAME					:= '~prct::IN::ct::propertyinfo';
	EXPORT BASE_PREFIX_NAME				:= '~prct::BASE::ct::propertyinfo';
	EXPORT MV_BASE_PREFIX_NAME		:= '~prct::MVBASE::ct::propertyinfo';
	EXPORT SPRAYED_PREFIX_NAME    := '~prct::SPRAYED::ct::propertyinfo';
	EXPORT KEY_PREFIX_NAME				:= '~prte::key::propertyinfo::';
	
	// New NANCY Spreadsheet layout matches Boca Base file layout
	EXPORT Alpha_Spray_Name				:= SPRAYED_PREFIX_NAME + '::'+ALPHA_Base_Name;
	EXPORT Alpha_Spray_DS					:= DATASET(Alpha_Spray_Name, Layouts.AlphaPropertyCSVRec,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	// Extra scramble names and DS for research/data repairs
	EXPORT Alpha_Spray1						:= SPRAYED_PREFIX_NAME + '::'+ALPHA_Base_Name+ '_1';
	EXPORT Alpha_Spray2						:= SPRAYED_PREFIX_NAME + '::'+ALPHA_Base_Name+ '_2';
	EXPORT Alpha_Spray_DS1				:= DATASET(Alpha_Spray1, Layouts.AlphaPropertyCSVRec,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	EXPORT Alpha_Spray_DS2				:= DATASET(Alpha_Spray2, Layouts.AlphaPropertyCSVRec,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// This is the alpharetta "Base" ... This is the PII base file, it's also scrambled.
	EXPORT PII_ALPHA_BASE_SF			:= BASE_PREFIX_NAME + '::qa::' + ALPHA_Base_Name;
	EXPORT PII_ALPHA_BASE_SF_DS		:= DATASET(PII_ALPHA_BASE_SF, Layouts.AlphaPropertyCSVRec, THOR);

	EXPORT ALPHA_MV_BASE_SF				:= BASE_PREFIX_NAME +'::'+ Alpha_MV_Suffix;
	EXPORT ALPHA_MV_BASE_DS				:= DATASET(ALPHA_MV_BASE_SF, Layouts.Boca_Official_Layout, THOR);

	EXPORT PropInfo_New_Subfile		:= IN_PREFIX_NAME+'::QA::'+NewData_Suffix;
	EXPORT PropInfo_New_Sub_DS		:= DATASET(PropInfo_New_Subfile, Layouts.AlphaPropertyCSVRec, THOR);
	
	// EXPORT BOCA_BASE_SF_DS							:= DATASET([], Layouts.AlphaPropertyCSVRec);

	// ****************************************************************************************************
	// These are here just for auditing - get_Payload does a persist to this name during the build.
	// It should be in the same layout as the base file, simply has recalculated clean addresses in it.
	EXPORT NewAlphaExpandedName 		:= '~prte::ct::propertyinfo::audit::newexpanded_Alpha';
	EXPORT NewAlphaExpandedDS				:= DATASET(NewAlphaExpandedName, Layouts.AlphaPropertyCSVRec, THOR);
	// Can these be switched to ~prct ?? or are there dependancies? are these base, should we use a base name?
	// More auditing files NEW_process_build_propertyinfo does an OUTPUT(,,Overwrite) to these
	EXPORT Alpha_PII_Final_Base_Name := BASE_PREFIX_NAME+'::Alpha_Final_Base';
	EXPORT Alpha_PII_Final_Base_DS	:= DATASET(Alpha_PII_Final_Base_Name, Layouts.Boca_Official_Layout, THOR);
	
	EXPORT STRING BuildKeyRIDName(STRING version) := KEY_PREFIX_NAME + version + '::rid';
	EXPORT STRING BuildKeyADDRName(STRING version) := KEY_PREFIX_NAME + version + '::address';
	// There are no SF's surrounding the logical CT files in Boca

	
	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT STRING BuildKeyRIDNameProd(STRING version) := Add_Foreign_prod(BuildKeyRIDName(version));
	EXPORT STRING BuildKeyADDRNameProd(STRING version) := Add_Foreign_prod(BuildKeyADDRName(version));
	EXPORT PII_ALPHA_BASE_SF_Prod				:= Add_Foreign_prod(PII_ALPHA_BASE_SF);
	EXPORT PII_ALPHA_BASE_SF_DS_Prod		:= DATASET(PII_ALPHA_BASE_SF_Prod, Layouts.AlphaPropertyCSVRec, THOR);
	EXPORT Alpha_PII_Final_Base_Nm_Prod := Add_Foreign_prod(Alpha_PII_Final_Base_Name);
	EXPORT Alpha_PII_Final_Base_DS_Prod	:= DATASET(Alpha_PII_Final_Base_Nm_Prod, Layouts.Boca_Official_Layout, THOR);
	
/*	OLD JUNK CODE, Review later then delete along with any PRTE2 code
	// EXPORT BOCA_BASE_SF_NAME_PROD				:= Add_Foreign_prod(BOCA_BASE_SF_NAME);
	// EXPORT BOCA_BASE_SF_DS_PROD					:= DATASET(BOCA_BASE_SF_NAME_PROD, Layouts.AlphaPropertyCSVRec, THOR);
	EXPORT Linda_PII_Scrambled_Prod := Add_Foreign_prod('~prte::in::custtest::csv::scrambled::propertyinfo9b');
	EXPORT Linda_Scrambled_DS_Prod 	:= DATASET(Linda_PII_Scrambled_Prod,	layouts.batch_in,
																		 CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
*/
END;