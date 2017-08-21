import ncpdp, strata, tools;

export out_STRATA_population_stats(
	 string																		pversion
	,boolean																	pIsTesting	= false
	,boolean																	pOverwrite	= false
) := function

	strata.mac_Pops(NCPDP.Files().keybuild_Base.QA,dpops);

	Strata.mac_CreateXMLStats(dpops,'NCPDP','baseV1',pversion,Email_Notification_Lists.Stats,resultsOut,'View','Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
	return if(tools.fun_IsValidVersion(pversion),
	sequential(resultsOut)
);
end;