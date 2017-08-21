export QA_Records(

	 dataset(Layouts.Base.Main                ) pBaseMain          = Files().Base.Main         .QA
	,dataset(Layouts.Base.StateLicense        ) pBaseStateLicense  = Files().Base.StateLicense .QA
	,dataset(Layouts.Base.Specialty           ) pBaseSpecialty     = Files().Base.Specialty    .QA
	,dataset(Layouts.Base.IDNumber						) pBaseIDNumber			 =	Files().Base.IDNumber		 .QA
	,dataset(Layouts.Base.Degree              ) pBaseDegree        = Files().Base.Degree       .QA
	,dataset(Layouts.Base.Credential          ) pBaseCredential    = Files().Base.Credential   .QA
	,dataset(Layouts.Base.Affiliation         ) pBaseAffiliation   = Files().Base.Affiliation  .QA

) :=
function

	//get new records for QA
	SampleFileMain                 := topn(pBaseMain                ,200,-dt_vendor_first_reported);
	SampleFileStateLicense         := topn(pBaseStateLicense        ,200,-dt_vendor_first_reported);
	SampleFileSpecialty            := topn(pBaseSpecialty           ,200,-dt_vendor_first_reported);
	SampleFileIDNumber						 := topn(pBaseIDNumber						,200,-dt_vendor_first_reported);
	SampleFileDegree               := topn(pBaseDegree              ,200,-dt_vendor_first_reported);
	SampleFileCredential           := topn(pBaseCredential          ,200,-dt_vendor_first_reported);
	SampleFileAffiliation          := topn(pBaseAffiliation         ,200,-dt_vendor_first_reported);

	SampleRecs := parallel(
		 output(SampleFileMain                ,named('SampleNewMainRecordsForQA'))
		,output(SampleFileStateLicense        ,named('SampleNewStateLicenseRecordsForQA'))
		,output(SampleFileSpecialty           ,named('SampleNewSpecialtyRecordsForQA'))
		,output(SampleFileIDNumber						,named('SampleNewIDNumberRecordsForQA'))
		,output(SampleFileDegree              ,named('SampleNewDegreeRecordsForQA'))
		,output(SampleFileCredential          ,named('SampleNewCredentialRecordsForQA'))
		,output(SampleFileAffiliation         ,named('SampleNewAffiliationRecordsForQA'))
	);
										
	return SampleRecs;

end;