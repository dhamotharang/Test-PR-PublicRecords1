IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT Addresses				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.Addresses.QA))) > 0;
		EXPORT Corporations			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.Corporations.QA))) > 0;
		EXPORT Directors				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.Directors.QA))) > 0;
		EXPORT Filings					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.Filings.QA))) > 0;
		EXPORT NameReservations	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.NameReservations.QA))) > 0;
		EXPORT Names						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.Names.QA))) > 0;
		EXPORT Officers					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.Officers.QA))) > 0;
		EXPORT Partners					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.Partners.QA))) > 0;
		EXPORT Stock						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.Stock.QA))) > 0;
		EXPORT PendingFilings		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.PendingFilings.QA))) > 0;
		EXPORT CorpOfficers			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NC.Filenames().Base.CorpOfficers.QA))) > 0;
		
	END;
	
END;