IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT CorpAction 	 := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NE.Filenames().Base.CorpAction.QA))) > 0;
		EXPORT CorpOfficers  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NE.Filenames().Base.CorpOfficers.QA))) > 0;
		EXPORT CorpEntity 	 := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NE.Filenames().Base.CorpEntity.QA))) > 0;
		EXPORT RegisterAgent := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NE.Filenames().Base.RegisterAgent.QA))) > 0;
	
	end;
	
end;