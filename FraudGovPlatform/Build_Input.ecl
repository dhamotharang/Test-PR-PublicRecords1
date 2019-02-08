import tools, FraudShared,FraudGovPlatform_Validation;
EXPORT Build_Input (
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
	,dataset(Layouts.OutputF.SkipModules) pSkipModules = FraudGovPlatform.Files().OutputF.SkipModules	 
	) :=
module

	// Modules
	export Run_Spray := FraudGovPlatform_Validation.SprayAndQualifyInput(pversion);
	export Run_IdentityData := Build_Input_IdentityData(pversion, MBS_Sprayed, pSkipModules ).All;
	export Run_KnownFraud :=  Build_Input_KnownFraud(pversion, MBS_Sprayed, pSkipModules).All;
	export Run_Deltabase := Build_Input_Deltabase(pversion, MBS_Sprayed).All;
	export Promote_Inputs := Promote(pversion).promote_inputs;
	export HeaderInfo_Post := HeaderInfo.Post;
	export AddressesInfo_Post := AddressesInfo(pversion).Post;

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			  Run_Spray
			, Run_IdentityData
			, Run_KnownFraud
			, Run_Deltabase
			, Promote_Inputs
			, HeaderInfo_Post
			, AddressesInfo_Post
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;