IMPORT FraudShared, tools;
EXPORT Build_Base(

	 string	pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 parallel(
				 Build_Base_IdentityData(pversion,MBS_Sprayed).All
				,Build_Base_KnownFraud(pversion,MBS_Sprayed).All	 
				,Build_Base_Deltabase(pversion,MBS_Sprayed).All
			 )
			 , Build_Base_AddressCache(pversion).All
			 , Promote(pversion).buildfiles.New2Built
			 , MapToCommon(pversion).Build_Base_Main_File.All
			 , Build_Base_Anonymized(pversion).All
			 , Append_DemoData(pversion)
			 , FraudgovInfo(pversion,'Base_Completed').postNewStatus
		) 
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 
