import strata, tools;

export Strata_Population_Stats(

	 string												pversion
	,boolean											pIsTesting	= false
	,boolean											pOverwrite	= false
	,dataset(layouts.base)				pBaseFile		= Files().Base.qa

) :=
function

	strata.mac_Pops(pBaseFile	,dpops);

	Strata.mac_CreateXMLStats(dpops,_Dataset().name	,'baseV1',pversion, Email_Notification_Lists().Stats,PopsOut,'View','Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
	return if(tools.fun_IsValidVersion(pversion),
	sequential(
		 PopsOut		
	));

end;