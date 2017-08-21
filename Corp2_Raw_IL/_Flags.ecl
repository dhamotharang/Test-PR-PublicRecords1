IMPORT corp2_raw_il;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
		
		EXPORT Daily := MODULE
			EXPORT MasterRaw		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.Daily.MasterRaw.QA))) > 0;
			EXPORT AssumedNames	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.Daily.AssumedNames.QA))) > 0;
			EXPORT Master				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.Daily.Master.QA))) > 0;
			EXPORT Stock				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.Daily.Stock.QA))) > 0;			
		END;
		
		EXPORT Monthly := MODULE
			EXPORT AssumedNames	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.Monthly.AssumedNames.QA))) > 0;
			EXPORT Master				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.Monthly.Master.QA))) > 0;
			EXPORT Stock				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.Monthly.Stock.QA))) > 0;
		END;	
		
		EXPORT LLC := MODULE
			EXPORT Master				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.LLC.Master.QA))) > 0;
		END;	
		
		EXPORT LP := MODULE
			EXPORT Master				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_IL.Filenames().Base.LP.Master.QA))) > 0;
		END;	
	
	END;
	
END;