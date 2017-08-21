export QA_Records(

	 dataset(layouts.Base		)	pBase			= files().base.qa
	,dataset(layouts.BaseXML)	pBaseXML	= files().baseXML.qa

) :=
function

	//get new records for QA
	samplefile		:= topn(pBase(did != 0, bdid != 0), 200, -dt_vendor_first_reported);
	samplexmlfile := topn(pBaseXML									, 200, -dt_vendor_first_reported);

	SampleRecs := parallel(
		 output(samplefile		,named('SampleNewRecordsForQA'		))
		,output(samplexmlfile	,named('SampleNewXmlRecordsForQA'	))
	);
										
	return SampleRecs;

end;