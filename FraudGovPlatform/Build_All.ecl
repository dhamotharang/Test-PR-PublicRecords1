﻿import tools, _control, FraudShared, Orbit3, Scrubs_MBS, FraudGovPlatform_Validation,STD;

export Build_All(

	 string																pversion
	,string																pContributoryServerIP 			= _control.IPAddress.bair_batchlz01
	,string																pContributoryDirectory 		= '/data/otto/in/'
	,string																pMBSServerIP 						= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,string																pMBSFDNServerIP 					= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,string																pMBSFraudGovDirectory			= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', '/data/super_credit/fraudgov/in/mbs/dev', '/data/super_credit/fraudgov/in/mbs/prod')
	,string																pMBSFDNDirectory					= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', '/data/super_credit/fdn/in/mbs/dev', '/data/super_credit/fdn/in/mbs/prod')
	// All sources are not updated each build if no updates to particular source skip that source base 
	,boolean															PSkipIdentityDataBase			= false 
	,boolean															PSkipKnownFraudBase				= false 
	,boolean															PSkipAddressCache					= false 
	,boolean															PSkipMainBase           		= false 
	,boolean															PSkipKelBase           		= false 
 	,dataset(FraudShared.Layouts.Base.Main)			pBaseMainFile						= IF(_Flags.Update.Main, FraudShared.Files().Base.Main.QA, DATASET([], FraudShared.Layouts.Base.Main))
	,dataset(Layouts.Base.IdentityData)				pBaseIdentityDataFile			= IF(_Flags.Update.IdentityData, Files().Base.IdentityData.QA, DATASET([], Layouts.Base.IdentityData))
	,dataset(Layouts.Base.KnownFraud)					pBaseKnownFraudFile				= IF(_Flags.Update.KnownFraud, Files().Base.KnownFraud.QA, DATASET([], Layouts.Base.KnownFraud))
	,dataset(Layouts.Input.IdentityData)				pUpdateIdentityDataFile		= Files().Input.IdentityData.Sprayed
	,dataset(Layouts.Input.KnownFraud)					pUpdateKnownFraudFile			= Files().Input.KnownFraud.Sprayed
	,dataset(FraudShared.Layouts.Base.Main)			pBaseMainBuilt						= File_keybuild(FraudShared.Files(pversion).Base.Main.Built)
	// This below flag is to run full file or update append if pUpdateIdentityDataflag = false full file run and true runs update append of the base file
	,boolean                                    	pUpdateIdentityDataFlag		= _Flags.Update.IdentityData
	,boolean                                     pUpdateKnownFraudFlag			= _Flags.Update.KnownFraud
	,boolean                                     PSkipKeysPortion					= false
) :=
module

	export Spray_MBS := sequential(
					FraudShared.Promote().Inputfiles.Sprayed2Using,
					FraudShared.Promote().Inputfiles.Using2Used,
					FraudShared.SprayMBSFiles(pversion := pVersion[1..8], pServerIP := pMBSServerIP,pDirectory := pMBSFraudGovDirectory),
					FraudGovPlatform_Validation.SprayMBSFiles(pversion := pVersion[1..8], pServerIP := pMBSFDNServerIP, pDirectory := pMBSFDNDirectory)
	);

//	export dops_update := RoxieKeyBuild.updateversion('IdentityDataKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															
	export input_portion := sequential(
			fraudgovInfo(pversion,'START_INPUT_FILES').PostStatus
			,Build_Input(
				 pversion
				,PSkipIdentityDataBase
				,PSkipKnownFraudBase
			 ).All
			,HeaderInfo.Post
			,AddressesInfo(pversion).Post				 
			,fraudgovInfo(pversion,'END_INPUT_FILES').PostStatus				 
	);

	export base_portion := sequential(
			fraudgovInfo(pversion,'START_BASE_FILES').PostStatus
		  	,Build_Base(
				 pversion
				,PSkipIdentityDataBase
				,PSkipKnownFraudBase
				,PSkipAddressCache
				,PSkipMainBase
				,PSkipKelBase
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
			).All
			,fraudgovInfo(pversion,'END_BASE_FILES').postFinish
			,notify('BASE FILES COMPLETE','*')
			,notify('Build_FraudGov_PII_SOAP_Appends','*')
			
	) : success(Send_Emails(pversion).BuildSuccess), failure(Send_Emails(pversion).BuildFailure);
	

	export keys_portion := sequential(
		  FraudShared.Build_Keys(
			 pversion
			,pBaseMainBuilt
			).All
		  ,FraudShared.Build_AutoKeys(
			 pversion
			,pBaseMainBuilt)
			// Promote Shared Files
			,FraudShared.Promote().buildfiles.Built2QA			
			// Clean Up Shared Files	
			,FraudShared.Promote().buildfiles.cleanup	
		) : success(Send_Emails(pversion).BuildSuccess), failure(Send_Emails(pversion).BuildFailure);	
	
	
	export full_build := sequential(
		 Spray_MBS
		,Create_Supers
		,input_portion
		,base_portion
		,if(PSkipKeysPortion, output('keys_portion skipped')
				,keys_portion)
	) : success(Send_Emails(pversion).BuildSuccess), failure(Send_Emails(pversion).BuildFailure);
	
	export Build_Base_Files :=
	if(tools.fun_IsValidVersion(pversion)
		,base_portion
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_All')
	);

	export Build_Key_Files :=
	if(tools.fun_IsValidVersion(pversion)
		,keys_portion
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_All')
	);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_All')
	);

	//	Scrubs (Which require ORBIT)
	EXPORT	ScrubsReports	:=	
	IF(tools.fun_IsValidVersion(pversion)
		,Scrubs_MBS.BuildSCRUBSReport(pversion)
		,OUTPUT('No Valid version parameter passed, skipping FraudGovPlatform.Build_All().ScrubsReports')
	) : SUCCESS(Send_Emails(pversion,pBuildMessage:='MBS Scrubs are complete').BuildMessage),
			FAILURE(Send_Emails(pversion).BuildFailure);
			
	//Create Orbit Builds
	export	create_build := Orbit3.proc_Orbit3_CreateBuild_AddItem('FraudGov',pversion);
	
end;