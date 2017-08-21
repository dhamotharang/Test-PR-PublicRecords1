import doxie, tools, versioncontrol;

export Build_Roxie_Keys(
	 string pversion = ''
  ,dataset(Layouts.Base.Main)         pBaseMainlnpidBuilt			=	Files(pversion).Base.Main.Built  
	,dataset(Layouts.Base.Credential)		pBaseCredentialBuilt		=	Files(pversion).Base.Credential.Built
	,dataset(Layouts.Base.Degree)				pBaseDegreeBuilt				=	Files(pversion).Base.Degree.Built
	,dataset(Layouts.Base.Specialty)		pBaseSpecialtyBuilt			=	Files(pversion).Base.Specialty.Built
	,dataset(Layouts.Base.StateLicense)	pBaseStateLicenseBuilt	=	Files(pversion).Base.StateLicense.Built
	,dataset(Layouts.Base.IDNumber)			pBaseIDNumberBuilt			=	Files(pversion).Base.IDNumber.Built
	,dataset(Layouts.Base.Affiliation)	pBaseAffiliationBuilt		=	Files(pversion).Base.Affiliation.Built
	,dataset(Layouts.Input.Code)				pUpdateCodeFile					=	Files().Input.Code.Using
) := module
  

	shared TheKeys := Keys(
		 pversion
		,pBaseMainlnpidBuilt
		,pBaseCredentialBuilt	
		,pBaseDegreeBuilt			
		,pBaseSpecialtyBuilt	
		,pBaseStateLicenseBuilt
		,pBaseIDNumberBuilt
		,pBaseAffiliationBuilt
		,pUpdateCodeFile);

	tools.mac_WriteIndex('TheKeys.Main.AMSID.New'								,BuildMainAmsIdKey				 );
	tools.mac_WriteIndex('TheKeys.Main.LNPID.New'								,BuildMainLnpIdKey				 );
	tools.mac_WriteIndex('TheKeys.Main.DID.New'									,BuildDidKey							 );
	tools.mac_WriteIndex('TheKeys.Main.BDID.New'								,BuildBdidKey							 );
	tools.mac_WriteIndex('TheKeys.Main.TaxID.New'								,BuildTaxIdKey						 );
	tools.mac_WriteIndex('TheKeys.Main.NPI.New'									,BuildNpiKey							 );
	tools.mac_WriteIndex('TheKeys.Main.LicenseNumberState.New'	,BuildLicenseNumberStateKey);
	tools.mac_WriteIndex('TheKeys.Main.LicenseNumber.New'				,BuildLicenseNumberKey     );
	tools.mac_WriteIndex('TheKeys.Main.LicenseState.New'				,BuildLicenseStateKey	     );
	tools.mac_WriteIndex('TheKeys.Credential.AMSID.New'					,BuildCredentialAmsIdKey	 );
	tools.mac_WriteIndex('TheKeys.Degree.AMSID.New'							,BuildDegreeAmsIdKey			 );
	tools.mac_WriteIndex('TheKeys.Specialty.AMSID.New'					,BuildSpecialtyAmsIdKey		 );
	tools.mac_WriteIndex('TheKeys.StateLicense.AMSID.New'				,BuildStateLicenseAmsIdKey );
	tools.mac_WriteIndex('TheKeys.IDNumber.AMSID.New'						,BuildIDNumberAmsIdKey		 );
	tools.mac_WriteIndex('TheKeys.Affiliation.AMSID.New'				,BuildAffiliationAmsIdKey	 );
	VersionControl.macBuildNewLogicalKeyWithName(Key_LinkIds.Key,Keynames(pversion).Main.LinkIds.New
																															,BuildLinkIdsKey           );																	  
	export full_build :=
	sequential(
		 parallel(
			 BuildMainAmsIdKey	
			,BuildMainLnpIdKey
			,BuildCredentialAmsIdKey	
			,BuildDegreeAmsIdKey			
			,BuildSpecialtyAmsIdKey		
			,BuildStateLicenseAmsIdKey
			,BuildIDNumberAmsIdKey		
			,BuildAffiliationAmsIdKey
			,BuildDidKey
			,BuildBdidKey
			,BuildTaxIdKey
			,BuildNpiKey
			,BuildLicenseNumberStateKey
			,BuildLicenseNumberKey
			,BuildLicenseStateKey
			,BuildLinkIdsKey
		 )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_Roxie_Keys atribute')
	);

end;