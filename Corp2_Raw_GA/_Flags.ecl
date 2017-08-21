IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT Corporation	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_GA.Filenames().Base.Corporation.QA))) > 0;
		EXPORT Address			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_GA.Filenames().Base.Address.QA))) 		 > 0;
		EXPORT Filing				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_GA.Filenames().Base.Filing.QA))) 	 	 > 0;
		EXPORT Officer			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_GA.Filenames().Base.Officer.QA))) 		 > 0;
		EXPORT Stock				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_GA.Filenames().Base.Stock.QA))) 			 > 0;
		EXPORT RAgent				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_GA.Filenames().Base.RAgent.QA))) 		 > 0;
		
	end;
	
end;