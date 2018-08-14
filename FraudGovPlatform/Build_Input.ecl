import tools, Scrubs_FraudGov, STD;
EXPORT Build_Input (
	 string			pversion
	,boolean		PSkipIdentityDataBase	= false 
	,boolean		PSkipKnownFraudBase		= false 
	) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 if(PSkipIdentityDataBase , output('IdentityData input skipped')
				,Build_Input_IdentityData(pversion).All)
			,if(PSkipKnownFraudBase , output('KnownFraud input skipped')
				,Build_Input_KnownFraud(pversion).All)	
			//Clear Individual Sprayed Files			
			,Promote(pVersion).inputfiles.Sprayed2Using
			,Promote(pVersion).inputfiles.Using2Used
			,Promote(pVersion).inputfiles.New2Sprayed			
			,Promote(pversion).sprayedfiles.Passed2Delete
			,Promote(pversion).sprayedfiles.Rejected2Delete
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;