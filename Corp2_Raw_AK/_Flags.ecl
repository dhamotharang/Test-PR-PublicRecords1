IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Corporations	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AK.Filenames().Base.Corporations.QA))) > 0;
		EXPORT Officials	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_AK.Filenames().Base.Officials.QA))) > 0;
	end;
end;
