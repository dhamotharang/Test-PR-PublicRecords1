IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT CorpBulk	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_ME.Filenames().Base.CorpBulk.QA))) > 0;
	end;
end;