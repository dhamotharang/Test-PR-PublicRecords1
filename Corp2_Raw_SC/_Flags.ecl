IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT CorpFile		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_SC.Filenames().Base.CorpFile.QA))) 	> 0;
		EXPORT CorpName		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_SC.Filenames().Base.CorpName.QA))) 	> 0;
		EXPORT CorpTXN		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_SC.Filenames().Base.CorpTXN.QA))) 		> 0;
	END;
END;