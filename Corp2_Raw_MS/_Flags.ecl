
EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Profiles	 := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MS.Filenames().Base.Profiles.QA))) > 0;
		EXPORT Forms	   := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MS.Filenames().Base.Forms.QA)))    > 0;
	end;
end;