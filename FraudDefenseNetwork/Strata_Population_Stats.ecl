import strata, tools;

export Strata_Population_Stats(

	 string																				pversion
	,boolean																			pIsTesting 			= false
	,boolean																			pOverwrite		 	= false
	,dataset(Layouts.Base.Main)										pBaseMainBuilt					= Files().Base.Main.Built
) :=
module

	Strata.mac_Pops(pBaseMainBuilt					,dMainPops				, 'source');
	
	Strata.mac_CreateXMLStats(dMainPops							,_Dataset().Name	,'main_base'	,pversion	,Email_Notification_Lists().Stats	,dMainPopsOut							,'View'								,'Population'	,,pIsTesting,pOverwrite);
		
	export all := if(tools.fun_IsValidVersion(pversion),
	sequential(
     dMainPopsOut
	));

end;