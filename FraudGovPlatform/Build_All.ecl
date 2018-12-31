import tools, _control, FraudShared, Orbit3, Scrubs_MBS, FraudGovPlatform_Validation,STD,FraudGovPlatform_Analytics;

export Build_All(

	 string																pversion
	,string																pContributoryServerIP 			= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.LandingZoneServer_dev,FraudGovPlatform_Validation.Constants.LandingZoneServer_prod)
	,string																pContributoryDirectory 		= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.ContributoryDirectory_dev,FraudGovPlatform_Validation.Constants.ContributoryDirectory_prod)
	,string																pMBSServerIP 						= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,string																pMBSFDNServerIP 					= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,string																pMBSFraudGovDirectory			= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.MBSLandingZonePathBase_dev, FraudGovPlatform_Validation.Constants.MBSLandingZonePathBase_prod)
	,string																pMBSFDNDirectory					= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.FDNMBSLandingZonePathBase_dev, FraudGovPlatform_Validation.Constants.FDNMBSLandingZonePathBase_prod)
	,string 															pDeltabaseRootDir 				= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.DeltaLandingZonePathBase_dev, FraudGovPlatform_Validation.Constants.DeltaLandingZonePathBase_prod)
	// All sources are not updated each build if no updates to particular source skip that source base 
	,boolean															PSkipIdentityDataBase			= false 
	,boolean															PSkipKnownFraudBase				= false 
	,boolean															PSkipDeltabaseBase				= false 
	,boolean															PSkipAddressCache					= false 
	,boolean															PSkipMainBase           		= false 
 	,dataset(FraudShared.Layouts.Base.Main)			pBaseMainFile						= IF(_Flags.Update.Main, FraudShared.Files().Base.Main.QA, DATASET([], FraudShared.Layouts.Base.Main))
	,dataset(Layouts.Base.IdentityData)				pBaseIdentityDataFile			= IF(_Flags.Update.IdentityData, Files().Base.IdentityData.QA, DATASET([], Layouts.Base.IdentityData))
	,dataset(Layouts.Base.KnownFraud)					pBaseKnownFraudFile				= IF(_Flags.Update.KnownFraud, Files().Base.KnownFraud.QA, DATASET([], Layouts.Base.KnownFraud))
	,dataset(Layouts.Base.Deltabase)						pBaseDeltabaseFile				= IF(_Flags.Update.Deltabase, Files().Base.Deltabase.QA, DATASET([], Layouts.Base.Deltabase))	
	,dataset(Layouts.Input.IdentityData)				pUpdateIdentityDataFile		= Files().Input.IdentityData.Sprayed
	,dataset(Layouts.Input.KnownFraud)					pUpdateKnownFraudFile			= Files().Input.KnownFraud.Sprayed
	,dataset(Layouts.Input.Deltabase)					pUpdateDeltabaseFile			= Files().Input.Deltabase.Sprayed
	,dataset(FraudShared.Layouts.Base.Main)			pBaseMainBuilt						= File_keybuild(FraudShared.Files(pversion).Base.Main.Built)
	// This below flag is to run full file or update append if pUpdateIdentityDataflag = false full file run and true runs update append of the base file
	,boolean                                    	pUpdateIdentityDataFlag		= _Flags.Update.IdentityData
	,boolean                                     pUpdateKnownFraudFlag			= _Flags.Update.KnownFraud
	,boolean                                     pUpdateDeltabaseFlag			= _Flags.Update.Deltabase
	,boolean                                     PSkipKeysPortion					= false
	,boolean 																		 pRunProd 								= False	// Default to Cert. Refreshs the RIN Analytics Dashboard in CERT/PROD 
	,boolean 																		 pUseProdData 						= True	// Default to prod data. The data used to refresh the RIN Analytics Dashboard

) :=
module

	shared yesterday_date := (unsigned)pVersion[1..8] - 1;

	export Spray_MBS := sequential(
					FraudShared.Promote().Inputfiles.Sprayed2Using,
					FraudShared.Promote().Inputfiles.Using2Used,
					FraudShared.SprayMBSFiles(pversion := pVersion[1..8], pServerIP := pMBSServerIP,pDirectory := pMBSFraudGovDirectory),
					FraudGovPlatform_Validation.SprayMBSFiles(		pversion := pVersion[1..8], 
																							pServerIP := pMBSFDNServerIP, 
																							pDirectory := pMBSFDNDirectory,
																							pFilenameMBSFdnCCID := 'mbsi_fdn_accounts_' + (string)yesterday_date + '*'
																						),
					If(_Flags.UseDemoData,FraudGovPlatform.Append_MBSDemoData(pversion).MbsIncl),
					Scrubs_MBS.BuildSCRUBSReport(pversion, FraudGovPlatform.Email_Notification_Lists().BuildSuccess)				
	);

//	export dops_update := RoxieKeyBuild.updateversion('IdentityDataKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															
	export input_portion := sequential(
			 Build_Input(
				 pversion
				,PSkipIdentityDataBase
				,PSkipKnownFraudBase
				,PSkipDeltabaseBase
			 ).All
			,HeaderInfo.Post
			,AddressesInfo(pversion).Post				 
	);

	Spray_Deltabase := FraudGovPlatform_Validation.SprayAndQualifyDeltabase(pversion,pMBSServerIP,pDeltabaseRootDir);
	
	export base_portion := sequential(
			Create_Supers
			,Spray_MBS
			,Spray_Deltabase
			,input_portion
		  	,Build_Base(
				 pversion
				,PSkipIdentityDataBase
				,PSkipKnownFraudBase
				,PSkipDeltabaseBase
				,PSkipAddressCache
				,PSkipMainBase
				//Base
				,pBaseMainFile	
				//IdentityData 
				,pBaseIdentityDataFile
				,pUpdateIdentityDataFile	
				,pUpdateIdentityDataFlag
				//KnownFraud
				,pBaseKnownFraudFile				
				,pUpdateKnownFraudFile	
				,pUpdateKnownFraudFlag
				//Deltabase
				,pBaseDeltabaseFile				
				,pUpdateDeltabaseFile	
				,pUpdateDeltabaseFlag				
			).All
			,FraudgovInfo(pversion,'Base_Completed').postNewStatus
			,notify('Base_Completed','*')
	);
	
	//Create Orbit Builds
	export	create_build := Orbit3.proc_Orbit3_CreateBuild_AddItem('FraudGov',pversion);
	export Build_FraudShared_Keys := sequential(

			//Clear Individual Sprayed Files			
			 Promote(pVersion).inputfiles.Sprayed2Using
			,Promote(pVersion).inputfiles.Using2Used
			,Promote(pVersion).inputfiles.New2Sprayed			
			,Promote(pversion).sprayedfiles.Passed2Delete
			,Promote(pversion).sprayedfiles.Rejected2Delete
			,Promote(pversion).buildfiles.Built2QA

			// Build FraudGov Keys
			,FraudShared.Build_Keys( pversion,	pBaseMainBuilt).All
			,if(_Flags.UseDemoData, 
				STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built,	Filenames().Input.DemoData.Sprayed))
		  	,FraudShared.Build_AutoKeys(pversion,	pBaseMainBuilt)

			//Create SOAP appends
			,FraudGovPlatform.Build_Base_Pii(pversion).All

			//Build KEL keys & files
			,FraudGovPlatform.Build_Kel(pversion).All

			// Promote Shared Files
			,FraudShared.Promote().buildfiles.Built2QA			
			// Clean Up Shared Files	
			,FraudShared.Promote().buildfiles.cleanup	
			,create_build
			,Send_Emails(pversion).Roxie
			,FraudGovPlatform_Analytics.GenerateDashboards(pRunProd,pUseProdData)
			,FraudgovInfo(pversion[1..8],'Keys_Completed').SetPreviousVersion			
		) : success(Send_Emails(pversion).BuildSuccess), failure(Send_Emails(pversion).BuildFailure);	

	export keys_portion := if(	Mac_TestBuild(pversion) 			= 'Passed' and 
												Mac_TestRecordID(pversion) 		= 'Passed' and 
												Mac_TestRinID(pversion) 			= 'Passed', 
												Build_FraudShared_Keys, 
												Rollback().All);
	
	export Build_FraudGov_Base := 
	if(tools.fun_IsValidVersion(pversion)
		,base_portion 
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base')
	): success(Send_Emails(pversion).BuildSuccess), failure(Send_Emails(pversion).BuildFailure);

	export Build_Fraudgov_Keys :=
	if(tools.fun_IsValidVersion(pversion)
		,keys_portion
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Keys')
	);
	
	export All :=
	if(tools.fun_IsValidVersion(pversion),
		 sequential(base_portion,keys_portion)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.All')
	);
		
end;