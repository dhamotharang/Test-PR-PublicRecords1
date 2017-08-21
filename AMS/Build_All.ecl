import RoxieKeyBuild, tools, _control, AMS._Flags;

export Build_All(

	 string																				pversion
	,string																				pDirectory											= '/data/data_build_4/AMS/data'
	,string																				pServerIP												= _control.IPAddress.bctlpedata11
	,boolean																			pIsTesting											= false
	,boolean																			pOverwrite											= false																															
	,boolean																			pReplicate											=	false
	,string																				pFilenameXref                 	= '*provider_xref*txt'
	,string																				pFilenameStateLicense         	= '*provider_state_license*txt'
	,string																				pFilenameSpecialty            	= '*provider_specialties*txt'
	,string																				pFilenameMerges               	= '*provider_merge*txt'
	,string																				pFilenameSplits               	= '*provider_split*txt'
	,string																				pFilenameProviderDemographics 	= '*provider_demographics*txt'
	,string																				pFilenameDegree               	= '*provider_degrees*txt'
	,string																				pFilenameCredential           	= '*provider_credentials*txt'
	,string																				pFilenameProviderAddress      	= '*provider_address*txt'
	,string																				pFilenameCode                 	= '*code*txt'
	,string																				pFilenameAffiliation          	= '*affiliations*txt'
	,string																				pFilenameAccountDemographics  	= '*account_demographics*txt'
	,string																				pFilenameAccountAddress       	= '*account_address*txt'
	,string																				pFilenameAccountMerges        	= '*account_merge*txt'
	,string																				pFilenameAccountSplits        	= '*account_split*txt'
	,string																				pGroupName											= _dataset().groupname																		
	,dataset(Layouts.Base.Main)										pBaseMainFile										=	IF(_Flags.Update.Main, Files().Base.Main.QA, DATASET([], Layouts.Base.Main))
	,dataset(Layouts.Base.Credential)							pBaseCredentialFile							=	IF(_Flags.Update.Credential, Files().Base.Credential.QA, DATASET([], Layouts.Base.Credential))
	,dataset(Layouts.Base.Degree)									pBaseDegreeFile									=	IF(_Flags.Update.Degree, Files().Base.Degree.QA, DATASET([], Layouts.Base.Degree))
	,dataset(Layouts.Base.Specialty)							pBaseSpecialtyFile							=	IF(_Flags.Update.Specialty, Files().Base.Specialty.QA, DATASET([], Layouts.Base.Specialty))
	,dataset(Layouts.Base.StateLicense)						pBaseStateLicenseFile						=	IF(_Flags.Update.StateLicense, Files().Base.StateLicense.QA, DATASET([], Layouts.Base.StateLicense))
	,dataset(Layouts.Base.Affiliation)						pBaseAffiliationFile						=	IF(_Flags.Update.Affiliation, Files().Base.Affiliation.QA, DATASET([], Layouts.Base.Affiliation))
	,dataset(Layouts.Base.IDNumber)								pBaseIDNumberFile								=	IF(_Flags.Update.IDNumber, Files().Base.IDNumber.QA, DATASET([], Layouts.Base.IDNumber))
	,dataset(Layouts.Input.ProviderDemographics)	pUpdateProviderDemographicsFile	=	Files().Input.ProviderDemographics.Sprayed
	,dataset(Layouts.Input.ProviderAddress)				pUpdateProviderAddressFile			=	Files().Input.ProviderAddress.Sprayed
	,dataset(Layouts.Input.AccountDemographics)		pUpdateAccountDemographicsFile	=	Files().Input.AccountDemographics.Sprayed
	,dataset(Layouts.Input.AccountAddress)				pUpdateAccountAddressFile				=	Files().Input.AccountAddress.Sprayed
	,dataset(Layouts.Input.Credential)						pUpdateCredentialFile						=	Files().Input.Credential.Sprayed
	,dataset(Layouts.Input.Degree)								pUpdateDegreeFile								=	Files().Input.Degree.Sprayed
	,dataset(Layouts.Input.Specialty)							pUpdateSpecialtyFile						=	Files().Input.Specialty.Sprayed
	,dataset(Layouts.Input.StateLicense)					pUpdateStateLicenseFile					=	Files().Input.StateLicense.Sprayed
	,dataset(Layouts.Input.Affiliation)						pUpdateAffiliationFile					=	Files().Input.Affiliation.Sprayed
	,dataset(Layouts.Input.Xref)									pUpdateXrefFile									=	Files().Input.Xref.Sprayed
	,dataset(Layouts.Input.Code)									pUpdateCodeFile									=	Files().Input.Code.Sprayed
	,dataset(Layouts.Base.Main)										pBaseMainBuilt									= Files(pversion).Base.Main.Built
	,dataset(Layouts.Base.Credential)							pBaseCredentialBuilt						=	Files(pversion).Base.Credential.Built
	,dataset(Layouts.Base.Degree)									pBaseDegreeBuilt								=	Files(pversion).Base.Degree.Built
	,dataset(Layouts.Base.Specialty)							pBaseSpecialtyBuilt							=	Files(pversion).Base.Specialty.Built
	,dataset(Layouts.Base.StateLicense)						pBaseStateLicenseBuilt					=	Files(pversion).Base.StateLicense.Built
	,dataset(Layouts.Base.IDNumber)								pBaseIDNumberBuilt							=	Files(pversion).Base.IDNumber.Built
	,dataset(Layouts.Base.Affiliation)						pBaseAffiliationBuilt						=	Files(pversion).Base.Affiliation.Built

) :=
module

	export spray_files := SprayFiles(
		 pServerIP
		,pDirectory 
		,pFilenameXref
		,pFilenameStateLicense
		,pFilenameSpecialty
		,pFilenameMerges
		,pFilenameSplits
		,pFilenameProviderDemographics
		,pFilenameDegree
		,pFilenameCredential
		,pFilenameProviderAddress
		,pFilenameCode
		,pFilenameAffiliation
		,pFilenameAccountDemographics
		,pFilenameAccountAddress
		,pFilenameAccountMerges
		,pFilenameAccountSplits
		,pversion
		,pGroupName
		,pIsTesting
		,pOverwrite
		,pReplicate
	);
	
	export dops_update := RoxieKeyBuild.updateversion('AMSKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															

	shared base_portion := sequential(
		 Create_Supers
		,spray_files
		,Build_Base(
			 pversion
			,pBaseMainFile									
			,pBaseCredentialFile						
			,pBaseDegreeFile								
			,pBaseSpecialtyFile							
			,pBaseStateLicenseFile	
			,pBaseAffiliationFile
			,pBaseIDNumberFile
			,pUpdateProviderDemographicsFile
			,pUpdateProviderAddressFile			
			,pUpdateAccountDemographicsFile	
			,pUpdateAccountAddressFile			
			,pUpdateCredentialFile					
			,pUpdateDegreeFile							
			,pUpdateSpecialtyFile						
			,pUpdateStateLicenseFile				
			,pUpdateAffiliationFile
			,pUpdateXrefFile
			,pUpdateCodeFile).All
			,notify('AMS BASE FILES COMPLETE','*');
			
	) : success(Send_Emails(pversion).Roxie), failure(Send_Emails(pversion).BuildFailure);
	
	shared Base_without_rid := project (pBaseMainBuilt,AMS.Layouts.Base.Main_Without_Rid);

	shared keys_portion := sequential(
		 Build_AutoKeys(
			 pversion
			,Base_without_rid)
		,Build_Roxie_Keys(
			 pversion
			,pBaseMainBuilt
			,pBaseCredentialBuilt	
			,pBaseDegreeBuilt			
			,pBaseSpecialtyBuilt	
			,pBaseStateLicenseBuilt
			,pBaseIDNumberBuilt
			,pBaseAffiliationBuilt
			,Files().Input.Code.Using).All
		,Promote().buildfiles.Built2QA
		,Promote().Inputfiles.Using2Used
		,QA_Records()
		,Strata_Population_Stats(
			 pversion
			,pIsTesting
			,pOverwrite
			,pBaseMainBuilt
			,pBaseCredentialBuilt
			,pBaseDegreeBuilt
			,pBaseSpecialtyBuilt
			,pBaseStateLicenseBuilt
			,pBaseIDNumberBuilt
			,pBaseAffiliationBuilt).All
		,dops_update
	) : success(Send_Emails(pversion).Roxie), failure(Send_Emails(pversion).BuildFailure);

  // Keeping the full build in case whatever's preventing it from working properly, gets fixed
	export full_build := sequential(
		 Create_Supers
		,spray_files
		,Build_Base(
			 pversion
			,pBaseMainFile									
			,pBaseCredentialFile						
			,pBaseDegreeFile								
			,pBaseSpecialtyFile							
			,pBaseStateLicenseFile	
			,pBaseAffiliationFile
			,pBaseIDNumberFile
			,pUpdateProviderDemographicsFile
			,pUpdateProviderAddressFile			
			,pUpdateAccountDemographicsFile	
			,pUpdateAccountAddressFile			
			,pUpdateCredentialFile					
			,pUpdateDegreeFile							
			,pUpdateSpecialtyFile						
			,pUpdateStateLicenseFile				
			,pUpdateAffiliationFile
			,pUpdateXrefFile
			,pUpdateCodeFile).All
		,Build_AutoKeys(
			 pversion
			,Base_without_rid)
		,Build_Roxie_Keys(
			 pversion
			,pBaseMainBuilt
			,pBaseCredentialBuilt	
			,pBaseDegreeBuilt			
			,pBaseSpecialtyBuilt	
			,pBaseStateLicenseBuilt
			,pBaseIDNumberBuilt
			,pBaseAffiliationBuilt
			,Files().Input.Code.Using).All
		,Promote().buildfiles.Built2QA
		,Promote().Inputfiles.Using2Used
		,QA_Records()
		,Strata_Population_Stats(
			 pversion
			,pIsTesting
			,pOverwrite
			,pBaseMainBuilt
			,pBaseCredentialBuilt
			,pBaseDegreeBuilt
			,pBaseSpecialtyBuilt
			,pBaseStateLicenseBuilt
			,pBaseIDNumberBuilt
			,pBaseAffiliationBuilt).All
		,dops_update

	) : success(Send_Emails(pversion).Roxie), failure(Send_Emails(pversion).BuildFailure);
	
	export Build_Base_Files :=
	if(tools.fun_IsValidVersion(pversion)
		,base_portion
		,output('No Valid version parameter passed, skipping AMS.Build_All')
	);

	export Build_Key_Files :=
	if(tools.fun_IsValidVersion(pversion)
		,keys_portion
		,output('No Valid version parameter passed, skipping AMS.Build_All')
	);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_All')
	);

end;