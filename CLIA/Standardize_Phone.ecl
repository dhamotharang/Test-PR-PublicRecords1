IMPORT tools;

EXPORT Standardize_Phone(DATASET(Layouts.Base) pRawFileInput) := FUNCTION

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- clear clean phone
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Base tPreProcessRecords(Layouts.Base L) := TRANSFORM
		SELF.clean_phones.Phone := '';

		SELF := L;
	END;
	
	dPreProcess := PROJECT(pRawFileInput, tPreProcessRecords(LEFT));

	tools.mac_AppendCleanPhone(dPreProcess, facility_phone, dzoomwithphone, clean_phones.Phone, , TRUE);

	RETURN dzoomwithphone;

END;
