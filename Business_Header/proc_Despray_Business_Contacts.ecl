import _control;
export proc_Despray_Business_Contacts(
	
	 string		pVersion
	,string		pServer			= _control.IPAddress.edata14a
	,string		pBusMount		= '/bus_hdr_16/'
	,string		pPawMount		= '/paw_16/'
	,boolean	pOverwrite	= false

) := 
function

	do_all := sequential(
	
		 MOXIE_BH_Contacts_Keys (pVersion)
		,promote(pversion,'moxie').New2Built
		,promote(pversion,'moxie').Built2QA
		,DKC_BH_Contacts_Keys 	(pServer,pBusMount,pOverwrite)	
		,MOXIE_Employment_Keys 	(pVersion)
		,promote(pversion,'moxie').New2Built
		,promote(pversion,'moxie').Built2QA
		,DKC_Employment_Keys 		(pServer,pPawMount,pOverwrite)	

	);

	return do_all;

end;