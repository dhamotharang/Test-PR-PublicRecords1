IMPORT FraudShared;
EXPORT Mac_TestBuild (   
	string pversion
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile	=	FraudShared.Files().Base.Main.Built
) :=
FUNCTION
	valid_build := if(fraudgovInfo(pversion).CurrentStatus != 'Base_Completed', 'Failed', 'Passed');
 	return valid_build;
END;