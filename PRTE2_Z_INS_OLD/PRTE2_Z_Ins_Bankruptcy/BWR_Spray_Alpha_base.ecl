//--------------------------------------------------------------------
// PRTE2_Bankruptcy.BWR_Spray_Alpha_base
// Project on hold.
// CT Bankruptcy are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------

// --------------------------------------------------------------------------------
//  PRTE2_Bankruptcy.BWR_Spray_Alpha_base 
// This is for spraying Alpha data from Nancy's Spreadsheets
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_Bankruptcy, PRTE2_Common;
#workunit('name', 'Boca PRCT2 Bankruptcy File Spray');

STRING fileVersion 	:= ut.GetDate+'';
CSVName_status 		:= 'Bankruptcy_20150520_status.csv';
CSVName_comments 	:= 'Bankruptcy_20150520_comments.csv';
CSVName_main 			:= 'Bankruptcy_20150520_main.csv';
CSVName_search 		:= 'Bankruptcy_20150520_search.csv';

// Testing if record Layouts in Boca and Alpharetta are the same
//-----------------------------------------------------------------------

Layout_Boca_status 		:= PRTE2_Common.get_ds_of_Layout(PRTE2_Bankruptcy.Layouts.status);
Layout_Alpha_status 	:= PRTE2_Common.get_ds_of_Layout(PRTE2_Bankruptcy.Layouts.Alpha_Check_status);
IFF(Layout_Boca_status != Layout_Alpha_status, 
		OUTPUT(ERROR('Record Layout \"status\" in Boca is modified, Please synchronize record Layouts before Spraying CSV file.'))
	);

Layout_Boca_comments 		:= PRTE2_Common.get_ds_of_Layout(PRTE2_Bankruptcy.Layouts.comments);
Layout_Alpha_comments 	:= PRTE2_Common.get_ds_of_Layout(PRTE2_Bankruptcy.Layouts.Alpha_Check_comments);
IFF(Layout_Boca_comments != Layout_Alpha_comments, 
		OUTPUT(ERROR('Record Layout \"comments\" in Boca is modified, Please synchronize record Layouts before Spraying CSV file.'))
	);

Layout_Boca_main 		:= PRTE2_Common.get_ds_of_Layout(PRTE2_Bankruptcy.Layouts.main);
Layout_Alpha_main 	:= PRTE2_Common.get_ds_of_Layout(PRTE2_Bankruptcy.Layouts.Alpha_Check_main);
IFF(Layout_Boca_main != Layout_Alpha_main, 
		OUTPUT(ERROR('Record Layout \"main\" in Boca is modified, Please synchronize record Layouts before Spraying CSV file.'))
	);

Layout_Boca_search 		:= PRTE2_Common.get_ds_of_Layout(PRTE2_Bankruptcy.Layouts.search);
Layout_Alpha_search 	:= PRTE2_Common.get_ds_of_Layout(PRTE2_Bankruptcy.Layouts.Alpha_Check_search);
IFF(Layout_Boca_search != Layout_Alpha_search, 
		OUTPUT(ERROR('Record Layout \"search\" in Boca is modified, Please synchronize record Layouts before Spraying CSV file.'))
	);

//-----------------------------------------------------------------------
// SourcePathForCSV := PRTE2_Phonesplus.Constants.SourcePathForCSV + '';

BuildFile_status 		:= PRTE2_Bankruptcy.FN_Spray_Alpha_base.status( 	CSVName_status, 	fileVersion /*,  SourcePathForCSV */); 
BuildFile_comments 	:= PRTE2_Bankruptcy.FN_Spray_Alpha_base.comments( CSVName_comments, fileVersion /*,  SourcePathForCSV */); 
BuildFile_main 			:= PRTE2_Bankruptcy.FN_Spray_Alpha_base.main( 		CSVName_main, 		fileVersion /*,  SourcePathForCSV */); 
BuildFile_search 		:= PRTE2_Bankruptcy.FN_Spray_Alpha_base.search( 	CSVName_search, 	fileVersion /*,  SourcePathForCSV */); 

SEQUENTIAL (	
						BuildFile_status
						,BuildFile_comments
						,BuildFile_main
						,BuildFile_search
						);

