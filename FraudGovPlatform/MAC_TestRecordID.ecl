IMPORT FraudShared;
EXPORT Mac_TestRecordID(   
	string pversion
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile	=	FraudShared.Files().Base.Main.QA
) := 
FUNCTION
	main := table(pBaseMainFile, {record_id; cnt := count(group)}, record_id );
	
	prev_recs := sort(distribute(FraudShared.Files().Base.Main.Father, hash32(record_id)), record_id, local);
	new_recs  := sort(distribute(main, hash32(record_id)), record_id, local);

	missingRecIDs := join(prev_recs, new_recs, left.record_id = right.record_id, left only);
	
 	return if (exists(main(main.cnt > 1)) OR count(missingRecIDs) > 1, 'Failed', 'Passed'); //E = Error Found
END;