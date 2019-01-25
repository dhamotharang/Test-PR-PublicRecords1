import tools, FraudShared,FraudGovPlatform_Validation;
EXPORT Build_Input (
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
	,dataset(Layouts.OutputF.SkipModules) pSkipModules = FraudGovPlatform.Files().OutputF.SkipModules	 
	) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 FraudGovPlatform_Validation.SprayAndQualifyInput(pversion)
			,Build_Input_IdentityData(pversion, MBS_Sprayed, pSkipModules ).All		
			,Build_Input_KnownFraud(pversion, MBS_Sprayed, pSkipModules).All			
			,Build_Input_Deltabase(pversion, MBS_Sprayed).All
			,HeaderInfo.Post
			,AddressesInfo(pversion).Post						
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;