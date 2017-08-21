/* ************************************************************************************
PRTE2_Phonesplus_Ins.Files

For the moment both we and Boca code are referencing Cross_Module_Files for file naming conventions.
NOTE: We only need file info here for a) Spray/DeSpray and b) Our Base file
************************************************************************************ */


IMPORT PRTE2_Common;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	
	EXPORT AllData_Suffix					:= PRTE2_Common.Cross_Module_Files.PhonesPlus_Suffix_Name;					// this is the base file
	SHARED MODULE_SUFFIX					:= PRTE2_Common.Cross_Module_Files.PhonesPlus_MODULE_SUFFIX;
	EXPORT Full_Prefix						:= PRTE2_Common.Cross_Module_Files.PhonesPlus_Full_Prefix;

	// ******** SPRAY FILES ******* these are temporary so not using Cross_Module naming 100% *************
	EXPORT IN_PREFIX_NAME					:= PRTE2_Common.Cross_Module_Files.MASTER_IN_PREFIX+MODULE_SUFFIX;
	EXPORT BASE_PREFIX_NAME				:= PRTE2_Common.Cross_Module_Files.MASTER_BASE_PREFIX+MODULE_SUFFIX;
	EXPORT SPRAYED_PREFIX_NAME		:= PRTE2_Common.Cross_Module_Files.MASTER_SPRAY_PREFIX+MODULE_SUFFIX;
	EXPORT SPRAY_BASE_NAME				:= 'PhonesPlusBase';		// only used for spray and despray
	EXPORT FILE_SPRAY							:= SPRAYED_PREFIX_NAME + '::'+SPRAY_BASE_NAME+ '_' + ThorLib.Wuid();
	EXPORT SPRAYED_DS							:= DATASET(FILE_SPRAY, Layouts.Alpha_CSV_Layout,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// ****************************************************************************************************
	// This is the full Base SF  *** Name also hard-coded in PRTE2_Common.Cross_Module_Files.PhonesPlus_Base_SF_name;
	EXPORT PhonesPlus_Base_SF			:= PRTE2_Common.Cross_Module_Files.PhonesPlus_Base_SF_Name;
	EXPORT PhonesPlus_Base_SF_DS	:= DATASET(PhonesPlus_Base_SF, Layouts.Alpha_CSV_Layout, THOR);
	// !!! This SF base DS is what the Boca build will need to read and append.

	// ****************************************************************************************************
	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT PhonesPlus_Base_SF_Prod				:= Add_Foreign_prod(PhonesPlus_Base_SF);
	EXPORT PhonesPlus_Base_SF_DS_Prod		:= DATASET(PhonesPlus_Base_SF_Prod, Layouts.Alpha_CSV_Layout, THOR);

// For more data to cleanse or to see what is populated - we might want the production base file reference.	
// Phonesplus_v2.File_Phonesplus_Base
// Interesting
// Phonesplus_v2.Fn_Rollup_as_Phonesplus
END;