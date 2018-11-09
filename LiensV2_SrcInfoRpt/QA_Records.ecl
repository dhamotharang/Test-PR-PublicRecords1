EXPORT QA_Records(
	DATASET(Layouts.rSourceInformationReport)		pSrcInfoRpt								= Files(Filenames().Input.srcinforpt.Used).SourceInformationReport,
	DATASET(Layouts.rSuppressedJurisdictions)		pSuppressedJurisdictions	= Files().SuppressedJurisdictions) := FUNCTION

	// get new records for QA
	SampleSrcInfoRpt							:=	TOPN(pSrcInfoRpt,								200,	LNCourtID);
	SampleSuppressedJurisdictions	:=	TOPN(pSuppressedJurisdictions,	200,	LNCourtID);

	SampleRecs := PARALLEL(OUTPUT(CHOOSEN(pSrcInfoRpt,200)					,			NAMED('SampleNewSrcInfoRptRecordsForQA')),
												 OUTPUT(CHOOSEN(pSuppressedJurisdictions,200)	,	NAMED('SampleNewSuppressedJurisdictionsRecordsForQA')));

	RETURN SampleRecs;

END;