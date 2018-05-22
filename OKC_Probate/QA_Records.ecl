IMPORT	OKC_Probate,	Header;
EXPORT QA_Records(
	DATASET(layout.base_raw)																		pOKCProbateBase	= Files().file_base,
	DATASET(header.Layout_Did_Death_MasterV3)	pOKCProbateV3			= Files().file_deathmasterv3) := FUNCTION

	// get new records for QA
	SampleOKCProbateBase	:=	TOPN(pOKCProbateBase,	200,	-filedate);
	SampleOKCProbateV3			:=	TOPN(pOKCProbateV3,			200,	-filedate);

	SampleRecs := PARALLEL(
																OUTPUT(CHOOSEN(SampleOKCProbateBase,200)	,	NAMED('SampleNewOKCProbateBaseRecordsForQA')),
																OUTPUT(CHOOSEN(SampleOKCProbateV3,200)			,	NAMED('SampleNewOKCProbateV3RecordsForQA')));

	RETURN SampleRecs;

END;