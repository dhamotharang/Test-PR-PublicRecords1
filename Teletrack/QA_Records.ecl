export QA_Records :=
function

	//get new records for QA
	samplefile := topn(Teletrack.files().base.qa, 200, -dt_vendor_first_reported);

	return output(samplefile, named('SampleTeletrackNewRecordsForQA'));

end;
