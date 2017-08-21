IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT Busentity	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_UT.Filenames().Base.Busentity.QA)))  > 0;
		EXPORT Businfo			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_UT.Filenames().Base.Businfo.QA))) 		> 0;
		EXPORT Principals		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_UT.Filenames().Base.Principals.QA))) > 0;
		
	end;
	
end;