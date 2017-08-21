IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT comfichex	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WI.Filenames().Base.comfichex.QA))) > 0;
		
	end;
	
end;