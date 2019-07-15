export QA_Records(
	dataset(layouts.base_new)	pBaseFile = files().base.qa
) :=
function
	//get new records for QA
	samplefile := topn(pBaseFile, 200, -date_vendor_first_reported);
	SampleRecs := output(samplefile, named('SampleNewRecordsForQA'));
										
	return SampleRecs;
end;
