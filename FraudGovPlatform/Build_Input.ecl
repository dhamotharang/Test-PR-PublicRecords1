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
			 parallel(
				 if(PSkipIdentityDataBase , output('IdentityData input skipped')
					,Build_Input_IdentityData(pversion).All)
				,if(PSkipKnownFraudBase , output('KnownFraud input skipped')
					,Build_Input_KnownFraud(pversion).All)	
			 )	
			//Clear Individual Sprayed Files
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataPassed, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataRejected, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._DeltabasePassed, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._DeltabaseRejected, TRUE)	
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._InquiryLogsPassed, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._InquiryLogsRejected, TRUE)				 
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACPassed, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACRejected, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudPassed, TRUE)
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudRejected, TRUE)
			,Scrubs_FraudGov.BuildSCRUBSReport(pversion) 
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Input atribute')
	 );
	 		
END;