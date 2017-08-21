IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT vendorRaw	:=COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_ID.Filenames().Base.vendorRaw.QA))) > 0;
		
	End;
	
end;