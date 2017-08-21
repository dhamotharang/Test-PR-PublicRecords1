IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Corporation	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NJ.Filenames().Base.Business.QA))) > 0;
	end;
end;
