// --------------------------------------------------------------------------------
//  PRTE2_Phonesplus_Ins.BWR_Spray_Base 
// This is for spraying regular Alpha data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
// *** someday, we should redo Fn_Spray_And_Build_BaseMain to split out a Build_base attribute
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_Phonesplus_Ins, PRTE2_Common;
#workunit('name', 'Boca PRCT PhonesPlus File Spray');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'';
CSVName := 'PhonesPlus_Base_PROD_20160823.csv';

BuildFile := PRTE2_Phonesplus_Ins.Fn_Spray_And_Build_BaseMain( CSVName, fileVersion ); 

SEQUENTIAL (BuildFile);

