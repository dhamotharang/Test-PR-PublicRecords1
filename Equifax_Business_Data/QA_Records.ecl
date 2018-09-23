
EXPORT QA_Records(DATASET(Equifax_Business_Data.layouts.base)	pBaseFile = Equifax_Business_Data.files().base.qa) 

  := FUNCTION

	//get new records for QA
	samplefile := TOPN(pBaseFile, 200, -dt_vendor_first_reported);

	SampleRecs := OUTPUT(samplefile, NAMED('SampleNewRecordsForQA'));
										
	RETURN SampleRecs;

END;