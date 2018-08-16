IMPORT FraudShared;
EXPORT Mac_TestRinID(   
	string pversion
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile	=	FraudShared.Files().Base.Main.QA
) := 
FUNCTION
	// Find Duplicate RinIDs on 2 or more different People

	t := table(pBaseMainFile(did >= Constants().FirstRinID), {raw_First_Name; raw_Last_Name; dob; did; });
	st := sort(t, raw_First_Name, raw_Last_Name, dob, did);
	dst := dedup(st, raw_First_Name, raw_Last_Name, dob, did);
	tdst := table(dst, {did; cnt := count(group)}, did , merge);

	//check that we don't lose RinIDs from previous file -  use a 1% treshld
	
	prev_recs := dedup(sort(distribute(FraudShared.Files().Base.Main.Father, hash32(did)), did, local),all);
	new_recs  := dedup(sort(distribute(pBaseMainFile, hash32(did)), did, local),all);

	missingRecIDs := join(prev_recs, new_recs, left.did = right.did, left only);	
	
	a := COUNT(prev_recs);
	b := COUNT(missingRecIDs);
	c := (b/a)*100;	
	
 	return if (exists(tdst(tdst.cnt > 1)) and c > 1, 'Failed', 'Passed'); //E = Error Found
	
END; 