export QA_Records :=
function

	//get new records for QA
	sampleCompaniesfile := topn(files().base.Companies.qa	,200	,-dt_vendor_first_reported);
	sampleContactsfile	:= topn(files().base.Contacts.qa	,200	,-dt_vendor_first_reported);

	return 
		parallel(
			 output(sampleCompaniesfile	,named('SampleNewCompanyRecordsForQA'	))
			,output(sampleContactsfile		,named('SampleNewContactsRecordsForQA'))
		);        

end;