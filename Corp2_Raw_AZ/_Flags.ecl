IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT COREXT := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AZ.Filenames().Base.COREXT.QA))) > 0;
		EXPORT CHGEXT := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AZ.Filenames().Base.CHGEXT.QA))) > 0;
		EXPORT FLMEXT := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AZ.Filenames().Base.FLMEXT.QA))) > 0;
		EXPORT OFFEXT := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AZ.Filenames().Base.OFFEXT.QA))) > 0;	
	end;
end;