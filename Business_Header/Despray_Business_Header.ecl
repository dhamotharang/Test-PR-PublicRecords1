import versioncontrol, _control;

export Despray_Business_Header(
	
	 string		pServer			= _control.IPAddress.edata14a
	,string		pMount			= '/bus_hdr_16/'
	,boolean	pOverwrite	= false

) := 
function


	myfilestodespray := dataset([
		
		{	 Bus_Thor() + 'OUT::Business_Relatives_Group_built',pServer,pMount + 'bus_relatives_group/bus_relatives_group.d00'}

	], versioncontrol.Layout_DKCs.Input);

	return versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayBusRelativesGroupInfo',pOverwrite);

end;