export QA_Records :=
function

	//get new records for QA
	samplefile := topn(POEsFromEmails.files().base.qa, 200, -date_last_seen);

	return output(samplefile, named('SamplePOEsFromEmailsNewRecordsForQA'));

end;
