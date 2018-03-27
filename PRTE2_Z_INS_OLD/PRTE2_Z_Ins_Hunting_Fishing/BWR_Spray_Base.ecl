// --------------------------------------------------------------------------------
//  PRTE2_Hunting_Fishing.BWR_Spray_Base 
// This is for spraying regular Alpha data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_Hunting_Fishing, PRTE2_Common;
#workunit('name', 'Boca PRCT HuntFish File Spray');

STRING fileVersion := ut.GetDate+'';
CSVName := 'HuntFish_Base_20140721.csv';

BuildFile := PRTE2_Hunting_Fishing.Fn_Spray_And_Build_BaseMain( CSVName, fileVersion ); 
SEQUENTIAL (BuildFile);
