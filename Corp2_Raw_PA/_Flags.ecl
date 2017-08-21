IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT CorpName	    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_PA.Filenames().Base.CorpName.QA)))     > 0;
		EXPORT Address			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_PA.Filenames().Base.Address.QA))) 			> 0;
		EXPORT Officer			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_PA.Filenames().Base.Officer.QA))) 		  > 0;
		EXPORT Corporations	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_PA.Filenames().Base.Corporations.QA))) > 0;
		EXPORT Filing				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_PA.Filenames().Base.Filing.QA))) 			> 0;
		EXPORT Merger				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_PA.Filenames().Base.Merger.QA))) 			> 0;
	end;
end;