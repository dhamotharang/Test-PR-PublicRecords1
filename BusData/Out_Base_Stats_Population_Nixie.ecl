import STRATA, _Control, tools;

export Out_Base_Stats_Population_Nixie(
	 string												pversion
	,boolean											pIsTesting	= false
	,boolean											pOverwrite	= false
) :=
function
	//SKA NIXIE BASE FILE
	strata.mac_Pops(BusData.File_SKA_Nixie_Base	,Strata_pops, 'State');

	Strata.mac_CreateXMLStats(Strata_pops,'SKA'	,'nixieV1',pversion, _Control.MyInfo.EmailAddressNotify,Strata_Stats_Base,'View','Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
	return if(tools.fun_IsValidVersion(pversion),Strata_Stats_Base);

end;