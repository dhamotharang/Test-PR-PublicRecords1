EXPORT QA_Records(
	DATASET(Layouts.rDBTAverage)		pDBTAverage		= Files().DBTAverage
) := FUNCTION

	// get new records for QA
	SampleDBTAverage		:=	TOPN(pDBTAverage,		200,	-dt_vendor_last_reported);

	SampleRecs := PARALLEL(OUTPUT(CHOOSEN(SampleDBTAverage,200)		,	NAMED('SampleNewDBTAverageRecordsForQA')));

	RETURN SampleRecs;

END;