IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Corporation	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NV.Filenames().Base.Corporation.QA))) > 0;
		EXPORT RA						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NV.Filenames().Base.RA.QA))) 				 > 0;
		EXPORT Officers			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NV.Filenames().Base.Officers.QA))) 	 > 0;
		EXPORT Actions			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NV.Filenames().Base.Actions.QA))) 		 > 0;
		EXPORT Stock				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NV.Filenames().Base.Stock.QA))) 			 > 0;
	END;
END;