IMPORT tools;

EXPORT Standardize_Phone(DATASET(Layouts.Base.Main) pRawFileInput) := FUNCTION

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- clear clean phone
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Base.Main tPreProcessRecords(Layouts.Base.Main L) := TRANSFORM
		SELF.clean_phone.phone := '';

		SELF := L;
	END;
	
	dPreProcess := PROJECT(pRawFileInput, tPreProcessRecords(LEFT));

	tools.mac_AppendCleanPhone(dPreProcess, phone_number, dzoomwithphone, clean_phone.phone, , TRUE);

	RETURN dzoomwithphone;

END;
