EXPORT QA_Records(DATASET(Layouts.Base.Main)           pBaseMain           = Files().Base.Main.QA,
									DATASET(Layouts.Base.Career)         pBaseCareer         = Files().Base.Career.QA,
									DATASET(Layouts.Base.Cert)           pBaseCert           = Files().Base.Cert.QA,
								  DATASET(Layouts.Base.Education)      pBaseEducation			 = Files().Base.Education.QA,
									DATASET(Layouts.Base.Membership)     pBaseMembership     = Files().Base.Membership.QA,
									DATASET(Layouts.Base.TypeOfPractice) pBaseTypeOfPractice = Files().Base.TypeOfPractice.QA) := FUNCTION

	// get new records for QA
	SampleFileMain           := TOPN(pBaseMain, 200, -dt_vendor_first_reported);
	SampleFileCareer         := TOPN(pBaseCareer, 200, -dt_vendor_first_reported);
	SampleFileCert           := TOPN(pBaseCert, 200, -dt_vendor_first_reported);
	SampleFileEducation			 := TOPN(pBaseEducation, 200, -dt_vendor_first_reported);
	SampleFileMembership     := TOPN(pBaseMembership, 200, -dt_vendor_first_reported);
	SampleFileTypeOfPractice := TOPN(pBaseTypeOfPractice, 200, -dt_vendor_first_reported);

	SampleRecs := PARALLEL(OUTPUT(SampleFileMain          , named('SampleNewMainRecordsForQA')),
												 OUTPUT(SampleFileCareer        , named('SampleNewCareerRecordsForQA')),
											 	 OUTPUT(SampleFileCert          , named('SampleNewCertRecordsForQA')),
												 OUTPUT(SampleFileEducation			, named('SampleNewEducationRecordsForQA')),
												 OUTPUT(SampleFileMembership    , named('SampleNewMembershipRecordsForQA')),
												 OUTPUT(SampleFileTypeOfPractice, named('SampleNewTypeOfPracticeRecordsForQA')));

	RETURN SampleRecs;

END;