export QA_Records(

	 dataset(layouts.Base		)	pBase			= files().base.qa

) :=
function

	//get new records for QA
	samplefile		:= topn(pBase(did != 0, bdid != 0), 200, -dt_last_seen);

	SampleRecs := parallel(
		 output(samplefile		,named('SampleNewRecordsForQA'		))
	);
										
	return SampleRecs;

end;