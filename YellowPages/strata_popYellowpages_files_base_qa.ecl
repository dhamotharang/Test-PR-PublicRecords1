import strata, tools;

export strata_popYellowpages_files_base_qa(

	 string																		pversion
	,boolean																	pIsTesting	= false
	,boolean																	pOverwrite	= false
	,dataset(Layout_YellowPages_Base_V2_BIP	)	pBaseFile		= Files().Base.built

) :=
function

	strata.mac_Pops(pBaseFile	,dpops	);

	Strata.mac_CreateXMLStats(dpops		,Constants().Name	,'baseV1',pversion, Email_Notification_Lists().Stats	,PopsOut		, 'View'							,'Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
	return if(tools.fun_IsValidVersion(pversion),
	sequential(
		 PopsOut		
	));

end;