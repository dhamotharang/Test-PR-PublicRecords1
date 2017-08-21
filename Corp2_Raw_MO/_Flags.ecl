IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT Address				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MO.Filenames().Base.Address.QA))) > 0;
		EXPORT Corporation		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MO.Filenames().Base.Corporation.QA))) > 0;
		EXPORT Filing					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MO.Filenames().Base.Filing.QA))) > 0;
		EXPORT Names					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MO.Filenames().Base.Names.QA))) > 0;
		EXPORT Officer				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MO.Filenames().Base.Officer.QA))) > 0;
		EXPORT merger					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MO.Filenames().Base.merger.QA))) > 0;
		EXPORT Stock					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MO.Filenames().Base.Stock.QA))) > 0;
		
	END;
	
END;