IMPORT FraudShared;
EXPORT Mac_TestRecordID(   
	string pversion
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile =	FraudShared.Files().Base.Main.Built
	,dataset(FraudShared.Layouts.Base.Main) pPreviousMain = if(_Flags.FileExists.Base.MainQA,FraudShared.Files().Base.Main.QA,DATASET([], FraudShared.Layouts.Base.Main)) 
) := 
FUNCTION
	main := table(pBaseMainFile, {record_id; cnt := count(group)}, record_id );
	
	prev_recs := sort(distribute(pPreviousMain, hash32(record_id)), record_id, local);
	new_recs  := sort(distribute(main, hash32(record_id)), record_id, local);

	missingRecIDs := join(prev_recs, new_recs, left.record_id = right.record_id, left only);
	
 	return if (exists(main(main.cnt > 1)) OR count(missingRecIDs) > 1, 'Failed', 'Passed'); //E = Error Found
END;