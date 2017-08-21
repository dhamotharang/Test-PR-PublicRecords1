import tools;

export Build_Base(

	 string																				pversion
	,dataset(Layouts.Base.Main)										pBaseMainFile										=	Files().Base.Main.QA
	,dataset(Layouts.Base.Credential)							pBaseCredentialFile							=	Files().Base.Credential.QA
	,dataset(Layouts.Base.Degree)									pBaseDegreeFile									=	Files().Base.Degree.QA
	,dataset(Layouts.Base.Specialty)							pBaseSpecialtyFile							=	Files().Base.Specialty.QA
	,dataset(Layouts.Base.StateLicense)						pBaseStateLicenseFile						=	Files().Base.StateLicense.QA
	,dataset(Layouts.Base.Affiliation)						pBaseAffiliationFile						=	Files().Base.Affiliation.QA
	,dataset(Layouts.Base.IDNumber)								pBaseIDNumberFile								=	Files().Base.IDNumber.QA
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
) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 parallel(
				 Build_Base_Main(
					 pversion
					,pBaseMainFile
					,pUpdateProviderDemographicsFile
					,pUpdateProviderAddressFile
					,pUpdateAccountDemographicsFile
					,pUpdateAccountAddressFile
					,pUpdateCodeFile).All
				,Build_Base_Credential(
					 pversion
					,pBaseCredentialFile
					,pUpdateCredentialFile
					,pUpdateCodeFile).All
				,Build_Base_Degree(
					 pversion
					,pBaseDegreeFile
					,pUpdateDegreeFile
					,pUpdateCodeFile).All
				,Build_Base_Specialty(
					 pversion
					,pBaseSpecialtyFile
					,pUpdateSpecialtyFile
					,pUpdateCodeFile).All
				,Build_Base_StateLicense(
					 pversion
					,pBaseStateLicenseFile
					,pUpdateStateLicenseFile
					,pUpdateCodeFile).All
				,Build_Base_Affiliation(
					 pversion
					,pBaseAffiliationFile
					,pUpdateAffiliationFile
					,pUpdateCodeFile).All
				,Build_Base_IDNumber(
					 pversion
					,pBaseIDNumberFile
					,pUpdateXrefFile
					,pUpdateCodeFile).All
			 )
			,Promote().Inputfiles.Sprayed2Using
		 )
		,output('No Valid version parameter passed, skipping AMS.Build_Base atribute')
	 );
		
end;