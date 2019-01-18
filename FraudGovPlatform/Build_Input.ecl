import tools, Scrubs_FraudGov, STD;
EXPORT Build_Input (
	 string			pversion
	,dataset(Layouts.OutputF.SkipModules) pSkipModules = FraudGovPlatform.Files().OutputF.SkipModules	 
	) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				 Build_Input_IdentityData(pversion, pSkipModules ).All			
				,Build_Input_KnownFraud(pversion, pSkipModules).All			
				,Build_Input_Deltabase(pversion).All				
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;