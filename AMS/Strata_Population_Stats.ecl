import strata, tools;

export Strata_Population_Stats(

	 string																				pversion
	,boolean																			pIsTesting 			= false
	,boolean																			pOverwrite		 	= false
	,dataset(Layouts.Base.Main)										pBaseMainBuilt					= Files().Base.Main.Built
	,dataset(Layouts.Base.Credential)							pBaseCredentialBuilt		=	Files().Base.Credential.Built
	,dataset(Layouts.Base.Degree)									pBaseDegreeBuilt				=	Files().Base.Degree.Built
	,dataset(Layouts.Base.Specialty)							pBaseSpecialtyBuilt			=	Files().Base.Specialty.Built
	,dataset(Layouts.Base.StateLicense)						pBaseStateLicenseBuilt	=	Files().Base.StateLicense.Built
	,dataset(Layouts.Base.IDNumber)								pBaseIDNumberBuilt			=	Files().Base.IDNumber.Built
	,dataset(Layouts.Base.Affiliation)						pBaseAffiliationBuilt		=	Files().Base.Affiliation.Built

) :=
module

	// shared fBusinessHeader	:=	fAMS_As_Business_Header		(pBaseMainBuilt);
	// shared fBusinessContact	:=	fAMS_As_Business_Contact	(pBaseMainBuilt,pBaseAffiliationBuilt);
	
	// strata.mac_Pops(fBusinessHeader					,dBusinessHeaderPops	,'source,state'											,,,,,,,['vl_id','rawaid'									]);
	// strata.mac_Pops(fBusinessContact				,dBusinessContactPops	,'source,state,record_type,from_hdr',,,,,,,['vl_id','rawaid','company_rawaid'	]);

	Strata.mac_Pops(pBaseMainBuilt					,dMainPops				, 'rawaddressfields.ams_state');
	Strata.mac_Pops(pBaseCredentialBuilt		,dCredentialPops		);
	Strata.mac_Pops(pBaseDegreeBuilt				,dDegreePops				);
	Strata.mac_Pops(pBaseSpecialtyBuilt			,dSpecialtyPops			);
	Strata.mac_Pops(pBaseStateLicenseBuilt	,dStateLicensePops, 'rawfields.st_lic_state'		);
	Strata.mac_Pops(pBaseIDNumberBuilt			,dIDNumberPops			);
	Strata.mac_Pops(pBaseAffiliationBuilt		,dAffiliationPops		);
	
	// Strata.mac_CreateXMLStats(dBusinessHeaderPops		,_Dataset().Name	,'main'					,pversion	,Email_Notification_Lists().Stats	,dBusinessHeaderPopsOut		,'AsBusinessHeader'		,'Population'	,,pIsTesting,pOverwrite);
	// Strata.mac_CreateXMLStats(dBusinessContactPops	,_Dataset().Name	,'main'					,pversion	,Email_Notification_Lists().Stats	,dBusinessContactPopsOut	,'AsBusinessContact'	,'Population'	,,pIsTesting,pOverwrite);

	Strata.mac_CreateXMLStats(dMainPops							,_Dataset().Name	,'main_baseV2'	,pversion	,Email_Notification_Lists().Stats	,dMainPopsOut							,'View'								,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dCredentialPops				,_Dataset().Name	,'credential'		,pversion	,Email_Notification_Lists().Stats	,dCredentialPopsOut				,'View'								,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dDegreePops						,_Dataset().Name	,'degree'				,pversion	,Email_Notification_Lists().Stats	,dDegreePopsOut						,'View'								,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dSpecialtyPops				,_Dataset().Name	,'specialty'		,pversion	,Email_Notification_Lists().Stats	,dSpecialtyPopsOut				,'View'								,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dStateLicensePops			,_Dataset().Name	,'statelicense'	,pversion	,Email_Notification_Lists().Stats	,dStateLicensePopsOut			,'View'								,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dIDNumberPops					,_Dataset().Name	,'idnumber'			,pversion	,Email_Notification_Lists().Stats	,dIDNumberPopsOut					,'View'								,'Population'	,,pIsTesting,pOverwrite);
	Strata.mac_CreateXMLStats(dAffiliationPops			,_Dataset().Name	,'affiliation'	,pversion	,Email_Notification_Lists().Stats	,dAffiliationPopsOut			,'View'								,'Population'	,,pIsTesting,pOverwrite);
	
	export all := if(tools.fun_IsValidVersion(pversion),
	sequential(
/*		 dBusinessHeaderPopsOut
		,dBusinessContactPopsOut
		,*/dMainPopsOut
		,dCredentialPopsOut
		,dDegreePopsOut
		,dSpecialtyPopsOut
		,dStateLicensePopsOut
		,dIDNumberPopsOut
		,dAffiliationPopsOut
	));

end;