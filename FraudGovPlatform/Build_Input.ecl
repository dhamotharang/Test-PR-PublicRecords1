import tools, FraudShared,FraudGovPlatform_Validation;
EXPORT Build_Input (
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
	) :=
module

	// Modules
	export Run_IdentityData := $.Build_Input_IdentityData(pversion, MBS_Sprayed).All:independent;
	export Run_KnownFraud :=  $.Build_Input_KnownFraud(pversion, MBS_Sprayed).All:independent;
	export Run_Deltabase := $.Build_Input_Deltabase(pversion, MBS_Sprayed).All:independent;
	export Run_DisposableEmailDomains := $.Build_Input_DisposableEmailDomains(pversion).All:independent;
	export Promote_Inputs := $.Promote(pversion).promote_inputs;

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				parallel(
					Run_IdentityData
				, Run_KnownFraud
				, Run_Deltabase
				, Run_DisposableEmailDomains )
			, Promote_Inputs
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;