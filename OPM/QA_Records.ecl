
EXPORT QA_Records(DATASET(OPM.layouts.base)	pBaseFile = OPM.files().base.qa) 

  := FUNCTION

	//get new records for QA
	samplefile := TOPN(pBaseFile(Employee_Name<>''), 200, -dt_vendor_first_reported);

	SampleRecs := OUTPUT(samplefile, NAMED('SampleNewRecordsForQA'));
										
	RETURN SampleRecs;

END;