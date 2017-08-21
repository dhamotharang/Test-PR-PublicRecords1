// --------------------------------------------------------------------------------
//  PRTE2_Phonesplus.BWR_Spray_Base 
// This is for spraying regular Alpha data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_Phonesplus, PRTE2_Common;
#workunit('name', 'Boca PRCT PhonesPlus File Spray');

STRING fileVersion := ut.GetDate+'';
CSVName := 'PhonesPlus_Csv_DEV_20151009.csv';

// Testing if record Layouts in Boca and Alpharetta are the same
//-----------------------------------------------------------------------
Layout_Boca := PRTE2_Common.get_ds_of_Layout(PRTE2_Phonesplus.Layouts.Alpharetta_Layout_Check);
Layout_Alpha := PRTE2_Common.get_ds_of_Layout(PRTE2_Phonesplus.Layouts.Alpha_CSV_Layout);
IFF(Layout_Boca != Layout_Alpha, 
		OUTPUT(ERROR('Record Layout in Boca is modified, Please synchronize record Layouts before Spraying CSV file.'))
	);
//-----------------------------------------------------------------------
// SourcePathForCSV := PRTE2_Phonesplus.Constants.SourcePathForCSV + '';

BuildFile := PRTE2_Phonesplus.Fn_Spray_And_Build_BaseMain( CSVName, fileVersion /*,  SourcePathForCSV */); 

SEQUENTIAL (BuildFile);

