IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Master   := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.Master.QA))) 	> 0;
		EXPORT ProcAddr := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.ProcAddr.QA))) > 0;
		EXPORT RegAgent := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.RegAgent.QA))) > 0;
		EXPORT FictName := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.FictName.QA))) > 0;
		EXPORT Stock    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.Stock.QA))) 		> 0;
		EXPORT Chairman := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.Chairman.QA))) > 0;
		EXPORT ExecOff  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.ExecOff.QA))) 	> 0;
		EXPORT OrigPart := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.OrigPart.QA))) > 0;
		EXPORT CurrPart := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.CurrPart.QA))) > 0;
		EXPORT Merger   := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NY.Filenames().Base.Merger.QA))) 	> 0;
	end;
end;