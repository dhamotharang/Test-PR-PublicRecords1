/* **********************************************************************************
PRTE2_Gong_Ins.BWR_Spray_Base
Simply spray the Scrambled data file into HPCC files ready now for the build.

NOTE: This is designed to spray the Alpha CSV base file (temp CSV file)
			then save that into a SF system as a Alpha Base file in our layout, 
			then finally transform that into Boca build base file in their layout.
********************************************************************************** */

IMPORT ut, PRTE2_Gong_Ins, PRTE2_Common;
#workunit('name', 'Alpha PRCT GONG File Spray');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'';
CSVName := 'Gong_Base_NewLayout3_20180530.csv';

BuildFile := PRTE2_Gong_Ins.Fn_Spray_And_Build_BaseMain( CSVName, fileVersion );

SEQUENTIAL (BuildFile);