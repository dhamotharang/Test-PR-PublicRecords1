IMPORT _Control, tools;
EXPORT _Flags(BOOLEAN puseprod) := MODULE
	EXPORT Base := MODULE
		EXPORT CorpsEntities			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_LA.Filenames(,puseprod).Base.CorpsEntities.QA)))	> 0;
		EXPORT Agents							:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_LA.Filenames(,puseprod).Base.Agents.QA))) 				> 0;
		EXPORT Filings						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_LA.Filenames(,puseprod).Base.Filings.QA))) 	 		> 0;
		EXPORT Mergers						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_LA.Filenames(,puseprod).Base.Mergers.QA))) 		 	> 0;
		EXPORT PreviousNames			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_LA.Filenames(,puseprod).Base.PreviousNames.QA)))	> 0;
		EXPORT TradeServices			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_LA.Filenames(,puseprod).Base.TradeServices.QA)))	> 0;
		EXPORT NameReservs				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_LA.Filenames(,puseprod).Base.NameReservs.QA))) 	> 0;
	END;
END;