/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
OLDER NOTES:
// PRTE2_PropertyInfo_Ins_MLS.Files
************************************************************************************************************************ */

IMPORT PRTE2_Common, PropertyCharacteristics;

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
	EXPORT Alpha_Spray_DS					:= DATASET(Alpha_Spray_Name, Layouts.AlphaPropertyCSVRec_MLS,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// This is here for the add-new process. This simply appends new, numbers the next seq number and fills some document fields with fake data.
	EXPORT PropInfo_New_fileName		:= IN_PREFIX_NAME+'::'+NewData_Suffix;
	EXPORT PropInfo_New_File_DS		:= DATASET(PropInfo_New_fileName, Layouts.AlphaPropertyCSVRec_MLS, THOR);
	
	// This is the alpharetta "Base" ... This is the PII base file, it's also scrambled.
	EXPORT PII_ALPHA_BASE_SF			:= BASE_PREFIX_NAME + '::' + ALPHA_Base_Name;
	EXPORT PII_ALPHA_BASE_SF_DS		:= DATASET(PII_ALPHA_BASE_SF, Layouts.AlphaPropertyCSVRec_MLS, THOR);

	// ************************************************************************************************************
	// ****** Copy of the base file needed for MapView Product builds in Alpharetta *******************************
	// ************************************************************************************************************
	EXPORT ALPHA_MV_BASE_SF				:= BASE_PREFIX_NAME +'::'+ Alpha_MV_Suffix;
	EXPORT ALPHA_MV_BASE_DS				:= DATASET(ALPHA_MV_BASE_SF, Layouts.Boca_Official_Layout, THOR);
	// ************************************************************************************************************

	// ****************************************************************************************************
	// These are here just for auditing - get_Payload does a persist to this name during the build.
	// It should be in the same layout as the base file, simply has recalculated clean addresses in it.
	EXPORT NewAlphaExpandedName 		:= '~prte::ct::propertyinfo::audit::newexpanded_Alpha';
	EXPORT NewAlphaExpandedDS				:= DATASET(NewAlphaExpandedName, Layouts.AlphaPropertyCSVRec_MLS, THOR);
	// Can these be switched to ~prct ?? or are there dependancies? are these base, should we use a base name?
	// More auditing files proc_build_propertyinfo does an OUTPUT(,,Overwrite) to these
	EXPORT Alpha_PII_Final_Base_Name := BASE_PREFIX_NAME+'::Alpha_Final_Base';
	EXPORT Alpha_PII_Final_Base_DS	:= DATASET(Alpha_PII_Final_Base_Name, Layouts.Boca_Official_Layout, THOR);
	
	EXPORT STRING BuildKeyRIDSimple := KEY_PREFIX_NAME + 'rid';
	EXPORT STRING BuildKeyRIDName(STRING version) := KEY_PREFIX_NAME + version + '::rid';
	EXPORT STRING BuildKeyRIDVName:= KEY_PREFIX_NAME + '@version@::rid';
	EXPORT STRING BuildKeyADDRSimple := KEY_PREFIX_NAME + 'address';
	EXPORT STRING BuildKeyADDRName(STRING version) := KEY_PREFIX_NAME + version + '::address';
	EXPORT STRING BuildKeyADDRVName:= KEY_PREFIX_NAME + '@version@::address';
	// There are no SF's surrounding the logical CT files in Boca

	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT STRING BuildKeyRIDNameProd(STRING version) := Add_Foreign_prod(BuildKeyRIDName(version));
	EXPORT STRING BuildKeyADDRNameProd(STRING version) := Add_Foreign_prod(BuildKeyADDRName(version));
	EXPORT PII_ALPHA_BASE_SF_Prod				:= Add_Foreign_prod(PII_ALPHA_BASE_SF);
	EXPORT PII_ALPHA_BASE_SF_DS_Prod		:= DATASET(PII_ALPHA_BASE_SF_Prod, Layouts.AlphaPropertyCSVRec_MLS, THOR);
	EXPORT Alpha_PII_Final_Base_Nm_Prod := Add_Foreign_prod(Alpha_PII_Final_Base_Name);
	EXPORT Alpha_PII_Final_Base_DS_Prod	:= DATASET(Alpha_PII_Final_Base_Nm_Prod, Layouts.Boca_Official_Layout, THOR);
	
	// ****************************************************************************************************
	// ***** These are here just for viewing keys contents as needed for auditing, etc.
	// ****************************************************************************************************
	EXPORT RealProdAddrKey := PropertyCharacteristics.Key_PropChar_Address;
	EXPORT RealProdRidKey 	:= PropertyCharacteristics.Key_PropChar_RID;

	SHARED CTRidKeyName := '~prte::key::propertyinfo::qa::rid';
	SHARED CTAddrKeyName := '~prte::key::propertyinfo::qa::address';
	SHARED CTRidKeyNameProd := Add_Foreign_prod(CTRidKeyName);
	SHARED CTAddrKeyNameProd := Add_Foreign_prod(CTAddrKeyName);

	EXPORT CT_Addr_Key := Index(RealProdAddrKey, CTAddrKeyName);		
	EXPORT CT_Rid_Key := Index(RealProdRidKey, CTRidKeyName);		
	EXPORT CT_Addr_KeyProd := Index(RealProdAddrKey, CTAddrKeyNameProd);		
	EXPORT CT_Rid_KeyProd := Index(RealProdRidKey, CTAddrKeyNameProd);	
	
END;