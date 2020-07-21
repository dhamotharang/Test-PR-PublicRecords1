
EXPORT QA_Records(DATASET(Equifax_Business_Data.layouts.base)	pBaseFile = Equifax_Business_Data.files().base.companies.qa
                 ,DATASET(Equifax_Business_Data.layouts.base_contacts) pBaseContactsFile = Equifax_Business_Data.files().base.contacts.qa
								 ) 

  := FUNCTION

	//get new records for QA
	samplefile := TOPN(pBaseFile, 200, -dt_vendor_first_reported);
	sampleContactsfile := TOPN(pBaseContactsFile, 200, -dt_vendor_first_reported);

	SampleRecs := OUTPUT(samplefile, NAMED('SampleNewRecordsForQA'));
	SampleContactRecs := OUTPUT(sampleContactsfile, NAMED('SampleNewContactsRecordsForQA'));
										
	RETURN parallel(
	                SampleRecs,
									SampleContactRecs
									);

END;