export QA_Records := function
	//get new records for QA
	samplefile := topn(files().base.qa, 200, -dt_vendor_first_reported);
	return output(samplefile, named('SampleNewRecordsForQA'));
end;