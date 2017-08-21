IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT FullFile		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MN.Filenames().Base.FullFile.QA))) > 0;
		EXPORT Master			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MN.Filenames().Base.Master.QA))) > 0;
		EXPORT FilingHist	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MN.Filenames().Base.FilingHist.QA))) > 0;
		EXPORT NameAddr   := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MN.Filenames().Base.NameAddr.QA))) > 0; 					
	END;
END;