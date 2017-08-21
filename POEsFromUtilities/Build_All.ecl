import tools,_control,utilfile,gong_v2,yellowpages; 
layYpbase := YellowPages.Layout_YellowPages_Base_V2_Bip;
export Build_All(
	
	 string																				pversion
	,boolean																			pIsTesting							= false
	,boolean																			pOverwrite							= false													
	,boolean																			pPullSourceDataFromProd	= _Dataset().IsDataland	// default to pull source data from prod on dataland													
	,dataset(utilfile.layout_util.base					) pUtilityBase						= utilfile.Files(,pPullSourceDataFromProd).fullbase.root
	,dataset(Gong_v2.layout_gongMasterAid				) pGongMasterBase					= Gong_v2.Files(,pPullSourceDataFromProd).base.gongmaster.root
	,dataset(layYpbase													) pYPBase									= YellowPages.Files(,pPullSourceDataFromProd).Base.qa

) :=
module

	export full_build :=
	sequential(
		 create_supers
		,Build_Base(pversion,pPullSourceDataFromProd,pUtilityBase,pGongMasterBase,pYPBase).All
		,Build_Keys(pversion).all
		,Build_Strata(pversion).all
		,Promote().Built2QA
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping POEsFromUtilities.Build_All')
	);

end;