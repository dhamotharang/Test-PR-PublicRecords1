IMPORT FraudShared, tools;
EXPORT Build_Base(

	 string	pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
) :=
module

	export Test_Build := Mac_TestBuild(pversion):independent;
	export Test_RecordID := Mac_TestRecordID(pversion):independent;
	export Test_RinID := Mac_TestRinID(pversion):independent;
	
	// Modules
	export Run_IdentityData := Build_Base_IdentityData(pversion,MBS_Sprayed).All;
	export Run_KnownFraud := Build_Base_KnownFraud(pversion,MBS_Sprayed).All;
	export Run_Deltabase := Build_Base_Deltabase(pversion,MBS_Sprayed).All;
	export Run_AddressCache := Build_Base_AddressCache(pversion).All;
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			  Run_IdentityData
			, Run_KnownFraud
			, Run_Deltabase
			, Run_AddressCache)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 
