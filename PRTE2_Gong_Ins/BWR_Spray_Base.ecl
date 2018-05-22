/* **********************************************************************************
PRTE2_Gong_Ins.BWR_Spray_Base
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_Gong_Ins, PRTE2_Common;
#workunit('name', 'Boca PRCT GONG File Spray');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'';
CSVName := 'prte_gong_insurance_base_20180514.csv';

BuildFile := PRTE2_Gong_Ins.Fn_Spray_And_Build_BaseMain( CSVName, fileVersion ); 

SEQUENTIAL (BuildFile);

