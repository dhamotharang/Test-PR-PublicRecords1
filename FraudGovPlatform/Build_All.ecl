import tools, _control, FraudShared, Orbit3, Scrubs_MBS;

export Build_All(

	 string																pversion
	,string																pServerIP 							= _control.IPAddress.bair_batchlz01
	,string																pDirectory 							= '/data/otto/in/'	 
	// All sources are not updated each build if no updates to particular source skip that source base 
	,boolean															PSkipIdentityDataBase			= false 
	,boolean															PSkipKnownFraudBase				= false 
	,boolean															PSkipAddressCache					= false 
	,boolean															PSkipMainBase           		= false 
 	,dataset(FraudShared.Layouts.Base.Main)			pBaseMainFile						= IF(_Flags.Update.Main, FraudShared.Files().Base.Main.QA, DATASET([], FraudShared.Layouts.Base.Main))
	,dataset(Layouts.Base.IdentityData)				pBaseIdentityDataFile			= IF(_Flags.Update.IdentityData, Files().Base.IdentityData.QA, DATASET([], Layouts.Base.IdentityData))
	,dataset(Layouts.Base.KnownFraud)					pBaseKnownFraudFile				= IF(_Flags.Update.KnownFraud, Files().Base.KnownFraud.QA, DATASET([], Layouts.Base.KnownFraud))
	,dataset(Layouts.Input.IdentityData)				pUpdateIdentityDataFile		= Files().Input.IdentityData.Sprayed
	,dataset(Layouts.Input.KnownFraud)					pUpdateKnownFraudFile			= Files().Input.KnownFraud.Sprayed
  ,dataset(FraudShared.Layouts.Base.Main)			pBaseMainBuilt						= File_keybuild(FraudShared.Files(pversion).Base.Main.Built)
	// This below flag is to run full file or update append if pUpdateIdentityDataflag = false full file run and true runs update append of the base file
	,boolean                                    	pUpdateIdentityDataFlag		= _Flags.Update.IdentityData
	,boolean                                     pUpdateKnownFraudFlag			= _Flags.Update.KnownFraud
) :=
module

//	export dops_update := RoxieKeyBuild.updateversion('IdentityDataKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															
	shared base_portion := sequential(
			Create_Supers
			,Build_Input(
				 pversion
				,PSkipIdentityDataBase
				,PSkipKnownFraudBase
			 ).All
			,_flags.HeaderInfo.Post
			,_flags.RefreshAddresses(pversion).Post				 
		  ,Build_Base(
				 pversion
				,PSkipIdentityDataBase
				,PSkipKnownFraudBase
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
			).All
			,notify('BASE FILES COMPLETE','*');
			
	) : success(Send_Emails(pversion).BuildSuccess), failure(Send_Emails(pversion).BuildFailure);
	

	shared keys_portion := sequential(
		  FraudShared.Build_Keys(
			 pversion
			,pBaseMainBuilt
			).All
		  ,FraudShared.Build_AutoKeys(
			 pversion
			,pBaseMainBuilt)
	) : success(Send_Emails(pversion).BuildSuccess), failure(Send_Emails(pversion).BuildFailure);	
	
	
	export full_build := sequential(
		 base_portion
		,keys_portion
		// Promote Contributory Files	
		,Promote().buildfiles.Built2QA
		// Promote Shared Files
		,FraudShared.Promote().Inputfiles.Sprayed2Using
		,FraudShared.Promote().buildfiles.Built2QA			
		,FraudShared.Promote().Inputfiles.Using2Used
		// Clean Up Shared Files	
		,FraudShared.Promote().buildfiles.cleanup		
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