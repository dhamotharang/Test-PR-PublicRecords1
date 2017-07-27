import strata, tools;

export Strata_Pop_Base(
	 string												pversion
	,boolean											pIsTesting	= false
	,boolean											pOverwrite	= false
) :=
function

	//ACF BASE FILE
	strata.mac_Pops(ACF.File_ACF_Base,Strata_pops,,'grouping','string3','ALL');

	Strata.mac_CreateXMLStats(Strata_pops,'ACF'	,'dataV1',pversion, Email_Notification_Lists().Stats,Strata_Stats_Base,'View','Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
	return if(tools.fun_IsValidVersion(pversion),Strata_Stats_Base);

end;