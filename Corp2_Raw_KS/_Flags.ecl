IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT CPABREP				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_KS.Filenames().Base.CPABREP.QA))) > 0;
		EXPORT CPADREP				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_KS.Filenames().Base.CPADREP.QA))) > 0;
		EXPORT CPAEREP				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_KS.Filenames().Base.CPAEREP.QA))) > 0;
		EXPORT CPAHST					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_KS.Filenames().Base.CPAHST.QA)))  > 0;
		EXPORT CPAQREP				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_KS.Filenames().Base.CPAQREP.QA))) > 0;
		EXPORT CPBCREP				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_KS.Filenames().Base.CPBCREP.QA))) > 0;	
	end;
end;