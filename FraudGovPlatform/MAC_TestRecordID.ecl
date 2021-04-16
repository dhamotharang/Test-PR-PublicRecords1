EXPORT Mac_TestRecordID(   
	string pversion
	,dataset(FraudGovPlatform.Layouts.Base.Main)	pBaseMainFile =	FraudGovPlatform.Files().Base.Main.Built
	,dataset(FraudGovPlatform.Layouts.Base.Main) pPreviousMain = FraudGovPlatform.Files().Base.Main.QA
) := 
FUNCTION
	
	prev_recs := sort(distribute(pPreviousMain, hash32(record_id)), record_id, local);
	new_recs  := sort(distribute(pBaseMainFile, hash32(record_id)), record_id, local);

	missingRecIDs := join(prev_recs, new_recs, left.record_id = right.record_id, left only, local);

	main := table(new_recs, {record_id; cnt := count(group)}, record_id );

 	return if (exists(main(main.cnt > 1)) OR count(missingRecIDs) > 1, 'Failed', 'Passed'); //E = Error Found
END;