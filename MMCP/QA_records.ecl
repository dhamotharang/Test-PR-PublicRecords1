EXPORT QA_Records(DATASET(Layouts.Base) pBaseMain = Files().Base.Main.QA) := FUNCTION

	//get new records for QA
	SampleFileMain := TOPN(pBaseMain, 200, -issue_date);

	SampleRecs := OUTPUT(SampleFileMain ( license_number <> ''), NAMED('SampleNewMainRecordsForQA'));

	RETURN SampleRecs;

END;