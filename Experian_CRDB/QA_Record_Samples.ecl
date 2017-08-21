EXPORT QA_Record_Samples (

	dataset(layouts.base)	pBaseFile = files().base.qa

) := function

	//get new records for QA
	sample_data1 := sort(pBaseFile(company_name<>'' and fname<>'' ), -dt_vendor_first_reported);//Company Records & Corresponding Contacts 

	SampleRecs :=output(choosen(sample_data1,500),named('CRDB_NewRec_Samples_For_QA'));
										
	return SampleRecs;

end;