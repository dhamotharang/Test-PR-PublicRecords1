import Busdata, STRATA, _Control, tools;

export Out_Base_Stats_Population_Verified(
	 string												pversion
	,boolean											pIsTesting	= false
	,boolean											pOverwrite	= false
) :=
function
	//SKA VERIFIED BASE FILE
	strata.mac_Pops(BusData.File_SKA_Verified_Base	,Strata_pops, 'STATE');

	Strata.mac_CreateXMLStats(Strata_pops,'SKA'	,'verifiedV1',pversion, _Control.MyInfo.EmailAddressNotify,Strata_Stats_Base,'View','Population',,pIsTesting,pOverwrite,pShouldExport := true);
	
	return if(tools.fun_IsValidVersion(pversion),Strata_Stats_Base);

end;