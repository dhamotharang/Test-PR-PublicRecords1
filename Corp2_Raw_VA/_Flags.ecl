IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Tables		    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.Tables.QA))) > 0;
		EXPORT Corps		    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.Corps.QA))) > 0;
		EXPORT LP   				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.LP.QA))) > 0;
		EXPORT Amendment   	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.Amendment.QA))) > 0;
		EXPORT Officer    	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.Officer.QA))) > 0;
		EXPORT NamesHist		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.NamesHist.QA))) > 0;
		EXPORT Merger    	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.Merger.QA))) > 0;
		EXPORT ResrvdName	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.ResrvdName.QA))) > 0;
		EXPORT LLC    			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VA.Filenames().Base.LLC.QA))) > 0;
		
	END;
END;