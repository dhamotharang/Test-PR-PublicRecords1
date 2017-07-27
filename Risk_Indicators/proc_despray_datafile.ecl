import versioncontrol, _control, business_header;

export proc_despray_datafile(
	
	 string		pServer					= _control.IPAddress.edata12
	,string		pMount					= '/thor_back5/local_data/hri/landing_zone/'
	,boolean	pOverwrite			= false
	,boolean	pShouldDespray	= true

) := 
function


	myfilestodespray := dataset([
		
		{	 Filenames().AddressSicCode.qa,pServer,pMount + 'hri.d00'}

	], versioncontrol.Layout_DKCs.Input);

	return versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayHRIInfo',pOverwrite,not pShouldDespray);

end;