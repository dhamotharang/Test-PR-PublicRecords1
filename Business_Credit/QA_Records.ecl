EXPORT QA_Records(
	DATASET(Layouts.SBFEAccountLayout)		pLinkIDs					= Files().LinkIDs,
	DATASET(Layouts.rBIClassification)		pBIClassification	= Files().BIClassification,
	DATASET(Layouts.rBusinessOwner)				pBusinessOwner		= Files().businessOwner,
	DATASET(Layouts.rCollateral)					pCollateral				= Files().Collateral,
	DATASET(Layouts.rHistory)							pHistory					= Files().History,
	DATASET(Layouts.rIndividualOwner)			pIndividualOwner	= Files().individualOwner,
	DATASET(Layouts.rMasterAccount)				pMasterAccount		= Files().MasterAccount,
	DATASET(Layouts.rMemberSpecific)			pMemberSpecific		= Files().MemberSpecific) := FUNCTION

	// get new records for QA
	SampleLinkIDs						:=	TOPN(pLinkIDs,					200,	-process_date);
	SampleBIClassification	:=	TOPN(pBIClassification,	200,	-process_date);
	SampleBusinessOwner			:=	TOPN(pBusinessOwner,		200,	-process_date);
	SampleCollateral				:=	TOPN(pCollateral,				200,	-process_date);
	SampleHistory						:=	TOPN(pHistory,					200,	-process_date);
	SampleIndividualOwner		:=	TOPN(pIndividualOwner,	200,	-process_date);
	SampleMasterAccount     :=	TOPN(pMasterAccount,		200,	-process_date);
	SampleMemberSpecific		:=	TOPN(pMemberSpecific,		200,	-process_date);

	SampleRecs := PARALLEL(OUTPUT(CHOOSEN(SampleLinkIDs,200)					,	named('SampleNewLinkIDsRecordsForQA')),
												 OUTPUT(CHOOSEN(SampleBIClassification,200)	,	named('SampleNewBIClassificationRecordsForQA')),
												 OUTPUT(CHOOSEN(SampleBusinessOwner,200)		,	named('SampleNewBusinessOwnerRecordsForQA')),
											 	 OUTPUT(CHOOSEN(SampleCollateral,200)				,	named('SampleNewCollateralRecordsForQA')),
												 OUTPUT(CHOOSEN(SampleHistory,200)					,	named('SampleNewHistoryRecordsForQA')),
												 OUTPUT(CHOOSEN(SampleIndividualOwner,200)	,	named('SampleNewIndividualOwnerRecordsForQA')),
												 OUTPUT(CHOOSEN(SampleMasterAccount,200)		,	named('SampleNewMasterAccountRecordsForQA')),
												 OUTPUT(CHOOSEN(SampleMemberSpecific,200)		,	named('SampleNewMemberSpecificRecordsForQA')));

	RETURN SampleRecs;

END;