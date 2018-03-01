import tools;
EXPORT Build_Input (
	 string			pversion
	,boolean		PSkipIdentityDataBase	= false 
	,boolean		PSkipKnownFraudBase		= false 
	,boolean		PSkipInquiryLogsBase	= false 
	,boolean		PSkipNACBase					= false
	) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 parallel(
				 if(PSkipIdentityDataBase , output('IdentityData input skipped')
					,Build_Input_IdentityData(pversion).All)
				,if(PSkipKnownFraudBase , output('KnownFraud input skipped')
					,Build_Input_KnownFraud(pversion).All)	
				,if(PSkipInquiryLogsBase , output('InquiryLogs input skipped')
					,Build_Input_InquiryLogs(pversion).All)		
				,if(PSkipNACBase , output('NAC input skipped')
					,Build_Input_NAC(pversion).All)		
			 )		 
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;