IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
	  EXPORT AmendHist			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.AmendHist.QA))) 	  > 0;	
		EXPORT ARCAmendHist		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.ARCAmendHist.QA))) > 0;	
		EXPORT BusAddr				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.BusAddr.QA))) 	    > 0;
		EXPORT ARCBusAddr			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.ARCBusAddr.QA))) 	> 0;
		EXPORT BusEntity			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.BusEntity.QA))) 	  > 0;
		EXPORT BusNmIndx			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.BusNmIndx.QA))) 	  > 0;
		EXPORT ARCBusNmIndx		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.ARCBusNmIndx.QA))) > 0;
		EXPORT BusType				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.BusType.QA)))  		> 0;
		EXPORT BusComment			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.BusComment.QA)))   > 0;
		EXPORT EntityStatus		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.EntityStatus.QA))) > 0;
		EXPORT FilingType			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.FilingType.QA))) 	> 0;
		EXPORT TradeName			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.TradeName.QA))) 		> 0;
		EXPORT FilmIndx				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.FilmIndx.QA))) 	  > 0;
		EXPORT ReserveName		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MD.Filenames().Base.ReserveName.QA))) 	> 0;
		
	END;
	
END;