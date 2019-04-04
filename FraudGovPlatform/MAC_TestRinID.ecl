IMPORT FraudShared;
EXPORT Mac_TestRinID(   
	string pversion
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile	=	FraudShared.Files().Base.Main.Built
	,dataset(FraudShared.Layouts.Base.Main) pPreviousMain = if(_Flags.FileExists.Base.MainQA,FraudShared.Files().Base.Main.QA,DATASET([], FraudShared.Layouts.Base.Main))
) := 
FUNCTION
	// Find Duplicate RinIDs on 2 or more different People

	t := dedup(table( pBaseMainFile (did >= FraudGovPlatform.Constants().FirstRinID), 
				{raw_First_Name; raw_Last_Name; dob; did;}, 
				raw_First_Name, raw_Last_Name, dob, did ));

	st := sort(t, raw_First_Name, raw_Last_Name, dob, did);
	dst := dedup(st, raw_First_Name, raw_Last_Name, dob, did);
	tdst := table(dst, {raw_First_Name, raw_Last_Name, dob, did, cnt := count(group)}, raw_First_Name, raw_Last_Name, dob, did , merge);

	//check that we don't lose RinIDs from previous file -  use a 1% treshld
	
	prev_recs := dedup(sort(distribute(pPreviousMain, hash32(did)), did, local),all);
	new_recs  := dedup(sort(distribute(pBaseMainFile, hash32(did)), did, local),all);

	missingRecIDs := join(prev_recs, new_recs, left.did = right.did, left only);	
	
	a := COUNT(prev_recs);
	b := COUNT(missingRecIDs);
	c := (b/a)*100;	
	
 	return if (exists(tdst(tdst.cnt > 1)) or c > 1, 'Failed', 'Passed'); //E = Error Found
	
END; 