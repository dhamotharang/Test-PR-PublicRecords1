import tools;
EXPORT Build_Input (
	 string			pversion
	,boolean		PSkipIdentityDataBase	= false 
	,boolean		PSkipKnownFraudBase		= false 
	) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 parallel(
				 if(PSkipIdentityDataBase , output('IdentityData input skipped')
					,Build_Input_IdentityData(pversion).All)
				,if(PSkipKnownFraudBase , output('IdentityData input skipped')
					,Build_Input_KnownFraud(pversion).All)	
			 )
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;