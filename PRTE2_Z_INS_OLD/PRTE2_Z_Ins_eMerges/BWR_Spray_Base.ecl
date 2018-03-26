// --------------------------------------------------------------------------------
//  PRTE2_eMerges.BWR_Spray_Base 
// This is for spraying regular Alpha data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_eMerges, PRTE2_Common;
#workunit('name', 'Boca PRCT eMerges File Spray');

STRING fileVersion := ut.GetDate+'';
CSVName := 'eMerges_Base_20140721.csv';  //??????????????????????????????

BuildFile := PRTE2_eMerges.Fn_Spray_And_Build_BaseMain( CSVName, fileVersion ); 
SEQUENTIAL (BuildFile);
