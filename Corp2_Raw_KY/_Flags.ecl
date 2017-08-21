IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT Companies				:= count(nothor(FileServices.SuperFileContents(Corp2_Raw_KY.Filenames().Base.Companies.QA))) > 0;
		EXPORT Officer					:= count(nothor(FileServices.SuperFileContents(Corp2_Raw_KY.Filenames().Base.Officer.QA))) > 0;
		EXPORT InitialOfficers	:= count(nothor(FileServices.SuperFileContents(Corp2_Raw_KY.Filenames().Base.InitialOfficers.QA))) > 0;

	end;
	
end;