IMPORT ALC;

EXPORT QA_Records(DATASET(ALC.Layouts.Base) pBaseMain = ALC.Files().Base.QA) := FUNCTION

	//get new records for QA
	SampleFileBase := TOPN(pBaseMain, 200, -dt_vendor_first_reported);

	SampleRecs := OUTPUT(SampleFileBase, NAMED('SampleNewBaseRecordsForQA'));

	RETURN SampleRecs;

END;