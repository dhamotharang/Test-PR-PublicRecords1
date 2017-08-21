IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT CorpData			:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.CorpData.QA))) 		> 0;
		EXPORT CorpNames	  := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.CorpNames.QA))) 	> 0;
		EXPORT CorpOfficer	:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.CorpOfficer.QA))) > 0;		
		
	end;
	
end;
