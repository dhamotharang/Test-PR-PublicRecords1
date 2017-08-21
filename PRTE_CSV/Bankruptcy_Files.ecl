IMPORT ut, PRTE_CSV;

EXPORT Bankruptcy_Files := module

	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName;

EXPORT status		:= dataset(lCSVFileNamePrefix + 'prte__base__bkv3__main_status_built.txt',PRTE_CSV.BK_Key_Layouts.status,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT comments	:= dataset(lCSVFileNamePrefix + 'prte__base__bkv3__main_comments_built.txt',PRTE_CSV.BK_Key_Layouts.comments,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT main			:= dataset(lCSVFileNamePrefix + 'prte__base__bkv3__main_built.txt',PRTE_CSV.BK_Key_Layouts.mainV3,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT search		:= dataset(lCSVFileNamePrefix + 'prte__base__bkv3__search_built.txt',PRTE_CSV.BK_Key_Layouts.searchV3,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
END;