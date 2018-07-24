IMPORT FraudShared;
EXPORT Mac_TestRinID(   
	string pversion
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile	=	FraudShared.Files().Base.Main.QA
) := 
FUNCTION
	t := table(pBaseMainFile(did >= Constants().FirstRinID), {raw_First_Name; raw_Last_Name; dob; did; });
	st := sort(t, raw_First_Name, raw_Last_Name, dob, did);
	dst := dedup(st, raw_First_Name, raw_Last_Name, dob, did);
	tdst := table(dst, {did; cnt := count(group)}, did , few);
	// Find Duplicate RinIDs on 2 or more different People
 	return if (exists(tdst(tdst.cnt > 1)), 'E', ''); //E = Error Found
END;