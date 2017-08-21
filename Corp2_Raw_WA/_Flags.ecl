
EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Corps	 := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WA.Filenames().Base.Corps.QA))) > 0;
	end;
end;