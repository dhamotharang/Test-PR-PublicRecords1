EXPORT Mac_TestBuild (   
	string pversion
	,dataset(FraudGovPlatform.Layouts.Base.Main)	pBaseMainFile	=	FraudGovPlatform.Files().Base.Main.Built
) :=
FUNCTION
	valid_build := if(fraudgovInfo(pversion).CurrentStatus != 'Base_Completed', 'Failed', 'Passed');
 	return valid_build;
END;