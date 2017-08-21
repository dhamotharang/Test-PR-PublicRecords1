IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT CorpAgents				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IN.Filenames().Base.CorpAgents.QA))) 			> 0;
		EXPORT CorpCorporations	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IN.Filenames().Base.CorpCorporations.QA))) > 0;
		EXPORT CorpFilings			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IN.Filenames().Base.CorpFilings.QA))) 			> 0;	
		EXPORT CorpMergers			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IN.Filenames().Base.CorpMergers.QA))) 			> 0;
		EXPORT CorpNames				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IN.Filenames().Base.CorpNames.QA))) 				> 0;
		EXPORT CorpOfficers			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IN.Filenames().Base.CorpOfficers.QA))) 		> 0;
		EXPORT CorpReports			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IN.Filenames().Base.CorpReports.QA))) 			> 0;
	END;
END;