IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Corporation			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NH.Filenames().Base.Corporation.QA))) > 0;
		EXPORT Address					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NH.Filenames().Base.Address.QA))) > 0;
		EXPORT Filing						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NH.Filenames().Base.Filing.QA))) > 0;
		EXPORT Merger						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NH.Filenames().Base.Merger.QA))) > 0;
		EXPORT CorporationName	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NH.Filenames().Base.CorporationName.QA))) > 0;
		EXPORT Officer					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NH.Filenames().Base.Officer.QA))) > 0;
		EXPORT Stock						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_NH.Filenames().Base.Stock.QA))) > 0;
	END;
END;