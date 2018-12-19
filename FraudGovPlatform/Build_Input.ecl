import tools, Scrubs_FraudGov, STD;
EXPORT Build_Input (
	 string			pversion
	,boolean		PSkipIdentityDataBase	= false 
	,boolean		PSkipKnownFraudBase		= false 
	,boolean		PSkipDeltabaseBase		= false
	) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 if(PSkipIdentityDataBase , output('IdentityData input skipped')
				,Build_Input_IdentityData(pversion).All)
			,if(PSkipKnownFraudBase , output('KnownFraud input skipped')
				,Build_Input_KnownFraud(pversion).All)	
			,if(PSkipDeltabaseBase , output('Deltabase input skipped')
				,Build_Input_Deltabase(pversion).All)					
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;