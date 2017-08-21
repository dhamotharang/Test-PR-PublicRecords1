
EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Mast	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CA.Filenames().Base.Mast.QA))) > 0;
		EXPORT Hist := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CA.Filenames().Base.Hist.QA))) > 0;
		EXPORT LP   := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CA.Filenames().Base.LP.QA)))   > 0;
	end;
end;