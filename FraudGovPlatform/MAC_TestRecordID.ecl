IMPORT FraudShared;
EXPORT Mac_TestRecordID(   
	string pversion
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile	=	FraudShared.Files().Base.Main.QA
) := 
FUNCTION
	t := table(pBaseMainFile, {record_id; cnt := count(group)}, record_id );
 	return if (exists(t(t.cnt > 1)), 'Failed', 'Passed'); //E = Error Found
END;