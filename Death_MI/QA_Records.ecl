EXPORT QA_Records(DATASET(Layouts.Base) pBaseMain = Files().Base.Main.QA) := FUNCTION

	//get new records for QA
	SampleFileMain := TOPN(pBaseMain, 200, -dt_vendor_first_reported);

	SampleRecs := OUTPUT(SampleFileMain, NAMED('SampleNewMainRecordsForQA'));

	RETURN SampleRecs;

END;