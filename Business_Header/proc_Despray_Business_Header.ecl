import _control;
export proc_Despray_Business_Header(
	
	 string		pVersion
	,string		pServer			= _control.IPAddress.edata14a
	,string		pMount			= '/bus_hdr_16/'
	,boolean	pOverwrite	= false

) := 
function

	do_all := sequential(
	
		 Despray_Business_Header(pServer,pMount,pOverwrite)	
		,MOXIE_BH_Keys					(pVersion)
		,promote(pversion,'moxie').New2Built
		,promote(pversion,'moxie').Built2QA
		,DKC_BH_Keys						(pServer,pMount,pOverwrite)	
		,MOXIE_BH_Relatives_Keys(pVersion)
		,MOXIE_BH_Best_Keys			(pVersion)
		,MOXIE_BH_Stats_Keys		(pVersion)
		,promote(pversion,'moxie').New2Built
		,promote(pversion,'moxie').Built2QA
		,DKC_BH_MISC_Keys				(pServer,pMount,pOverwrite)				

	);

	return do_all;

end;