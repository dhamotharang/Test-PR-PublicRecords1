// --------------------------------------------------------------------------------
//  PRTE2_Phonesplus_Ins.BWR_Spray_Base 
// This is for spraying regular Alpha data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

//**********************************************************************************
//TODO ****** WE should re-run this and append the little GE data too. ************
//**********************************************************************************

IMPORT ut, PRTE2_Phonesplus_Ins, PRTE2_Common, PRTE_CSV;
#workunit('name', 'Boca PRCT PhonesPlus File Spray');

STRING fileVersion := ut.GetDate+'b';
DS1 := PRTE_CSV.PhonesPlus.dthor_data400__key__phonesplus__did;
newBase := DS1;

// This macro is what builds the super files with generations: QA, Father, Grandfater
RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																		 PRTE2_Phonesplus_Ins.Files.BASE_PREFIX_NAME, 
																		 PRTE2_Phonesplus_Ins.Files.BASE_NAME,
																		 fileVersion, buildBase, 3,
																		 false,true);
																						 
SEQUENTIAL (buildBase);

