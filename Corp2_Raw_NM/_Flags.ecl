IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Corporation	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NM.Filenames().Base.ImportMaster.QA))) > 0;
	end;
end;