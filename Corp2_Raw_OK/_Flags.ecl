IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT f01_Entity	    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f01_Entity.QA)))     > 0;
		EXPORT f02_Address	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f02_Address.QA)))    > 0;
		EXPORT f03_Agent	    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f03_Agent.QA)))      > 0;
		EXPORT f04_Officer	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f04_Officer.QA)))    > 0;
		EXPORT f05_Names	    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f05_Names.QA)))      > 0;
		EXPORT f06_AssocEnt	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f06_AssocEnt.QA)))    > 0;
		EXPORT f07_StockData	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f07_StockData.QA)))  > 0;
		EXPORT f08_StockInfo	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f08_StockInfo.QA)))	> 0;
		EXPORT f12_CorpType	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f12_CorpType.QA)))   > 0;
		EXPORT f17_CorpFiling := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OK.Filenames().Base.f17_CorpFiling.QA))) > 0;
	end;
end;
