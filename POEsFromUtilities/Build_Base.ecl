import tools,utilfile,gong_v2,yellowpages;
layYpbase := YellowPages.Layout_YellowPages_Base_V2_Bip;

export Build_Base(

	 string																				pversion
	,boolean																			pPullSourceDataFromProd	= false													
	,dataset(utilfile.layout_util.base					) pUtilityBase						= utilfile.Files(,pPullSourceDataFromProd).fullbase.root
	,dataset(Gong_v2.layout_gongMasterAid				) pGongMasterBase					= Gong_v2.Files(,pPullSourceDataFromProd).base.gongmaster.root
	,dataset(layYpbase													) pYPBase									= YellowPages.Files().Base.qa

) :=
module

	shared dUpdate := Update_Base(pPullSourceDataFromProd,pUtilityBase,pGongMasterBase,pYPBase);

	tools.mac_WriteFile(Filenames(pversion).base.new	,dUpdate	,Build_Base_File	);
	
	export full_build :=
	sequential(
		 Build_Base_File
		,Promote(pversion).New2Built

	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping POEsFromUtilities.Build_Base attribute')
	);
		
end;