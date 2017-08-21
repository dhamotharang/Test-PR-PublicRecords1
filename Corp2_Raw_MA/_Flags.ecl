IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT CorpDataExport				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MA.Filenames().Base.CorpDataExport.QA))) 				> 0;
		EXPORT CorpIndividualExport	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MA.Filenames().Base.CorpIndividualExport.QA))) 	> 0;
		EXPORT CorpNameChange				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MA.Filenames().Base.CorpNameChange.QA))) 	 			> 0;
		EXPORT CorpMerger						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MA.Filenames().Base.CorpMerger.QA))) 		 				> 0;
		EXPORT CorpDetailExport			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MA.Filenames().Base.CorpDetailExport.QA))) 			> 0;
		EXPORT CorpStockExport			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MA.Filenames().Base.CorpStockExport.QA))) 			 	> 0;
	END;
END;