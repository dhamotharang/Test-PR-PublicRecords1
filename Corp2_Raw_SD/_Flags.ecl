IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT vendor_main	     := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_SD.Filenames().Base.vendor_main.QA))) > 0;
		EXPORT vendor_amendments := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_SD.Filenames().Base.vendor_amendments.QA))) > 0;
		EXPORT vendor_ar         := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_SD.Filenames().Base.vendor_ar.QA))) > 0;
	END;
END;