IMPORT	FirstData;
EXPORT QA_Records(
	DATASET(layout.base)	pFirstDataBase			= Files().file_base) := FUNCTION

	// get new records for QA
	SampleFirstDataBase	:=	TOPN(pFirstDataBase,	200,	-filedate);

	SampleRecs := OUTPUT(CHOOSEN(SampleFirstDataBase,200)	,	NAMED('SampleNewFirstDataBaseRecordsForQA'));													

	RETURN SampleRecs;

END;