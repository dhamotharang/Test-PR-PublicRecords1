
EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Corp	       := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_ND.Filenames().Base.Corp.QA)))        > 0;
		EXPORT FictName	   := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_ND.Filenames().Base.FictName.QA)))    > 0;
		EXPORT Partnership := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_ND.Filenames().Base.Partnership.QA))) > 0;
		EXPORT TradeMark	 := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_ND.Filenames().Base.TradeMark.QA))) 	> 0;
	  EXPORT TradeName	 := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_ND.Filenames().Base.TradeName.QA))) 	> 0;
	 end;
end;