IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT CompanyMaster			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_HI.Filenames().Base.CompanyMaster.QA))) > 0;
		EXPORT CompanyOfficer			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_HI.Filenames().Base.CompanyOfficer.QA))) > 0;
		EXPORT CompanyStock				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_HI.Filenames().Base.CompanyStock.QA))) > 0;
		EXPORT CompanyTransaction	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_HI.Filenames().Base.CompanyTransaction.QA))) > 0;
		EXPORT TtsMaster					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_HI.Filenames().Base.TtsMaster.QA))) > 0;
		EXPORT TtsTransaction			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_HI.Filenames().Base.TtsTransaction.QA))) > 0;
	END;
END;