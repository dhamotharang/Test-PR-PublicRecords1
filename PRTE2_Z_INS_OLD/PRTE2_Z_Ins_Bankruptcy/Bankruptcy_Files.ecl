//--------------------------------------------------------------------
// PRTE2_Bankruptcy.Bankruptcy_Files
// Project on hold.
// CT Bankruptcy are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------

// This will need to be saves as PRTE_CSV.Bankruptcy_Files   to work as intended. ( this is work in progress ).
IMPORT PRTE2_Bankruptcy, ut, PRTE_CSV;

EXPORT Bankruptcy_Files := module
	shared Combine_Alpharetta_data := true;   // if true Alpharetta data will be added to Boca data 
	
	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName;

	EXPORT Boca_status		:= dataset(lCSVFileNamePrefix + 'prte__base__bkv3__main_status_built.txt',PRTE_CSV.BK_Key_Layouts.status,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT Boca_comments	:= dataset(lCSVFileNamePrefix + 'prte__base__bkv3__main_comments_built.txt',PRTE_CSV.BK_Key_Layouts.comments,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT Boca_main			:= dataset(lCSVFileNamePrefix + 'prte__base__bkv3__main_built.txt',PRTE_CSV.BK_Key_Layouts.mainV3,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT Boca_search		:= dataset(lCSVFileNamePrefix + 'prte__base__bkv3__search_built.txt',PRTE_CSV.BK_Key_Layouts.searchV3,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

	EXPORT Alpha_status		:= dataset(Alpha_CSVFileNamePrefix + 'prte__base__bkv3__main_status_built.txt',PRTE_CSV.BK_Key_Layouts.status,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT Alpha_comments	:= dataset(Alpha_CSVFileNamePrefix + 'prte__base__bkv3__main_comments_built.txt',PRTE_CSV.BK_Key_Layouts.comments,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT Alpha_main			:= dataset(Alpha_CSVFileNamePrefix + 'prte__base__bkv3__main_built.txt',PRTE_CSV.BK_Key_Layouts.mainV3,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT Alpha_search		:= dataset(Alpha_CSVFileNamePrefix + 'prte__base__bkv3__search_built.txt',PRTE_CSV.BK_Key_Layouts.searchV3,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

	EXPORT status		:= IF(Combine_Alpharetta_data, Boca_status 		+ Alpha_status,		Boca_status);
	EXPORT comments	:= IF(Combine_Alpharetta_data, Boca_comments 	+ Alpha_comments,	Boca_comments);
	EXPORT main			:= IF(Combine_Alpharetta_data, Boca_main 			+ Alpha_main,			Boca_main);
	EXPORT search		:= IF(Combine_Alpharetta_data, Boca_search 		+ Alpha_search,		Boca_search);

END;
