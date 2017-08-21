IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Filing		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WY.Filenames().Base.Filing.QA))) > 0;
		EXPORT FilingAR	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WY.Filenames().Base.FilingAR.QA))) > 0;
		EXPORT Party		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WY.Filenames().Base.Party.QA))) > 0;	
	END;
END;