import _control;
export proc_Despray_All(
	
	 string		pVersion
	,string		pServer								= _control.IPAddress.edata14a
	,string		pBusMount							= '/bus_hdr_16/'
	,boolean	pOverwrite						= false
	,boolean	pShouldDkcKeys				= true
	
) := 
function

	do_all := sequential(
		 MOXIE_BH_Keys					(pVersion)
		,MOXIE_BH_Relatives_Keys(pVersion)
		,MOXIE_BRG_KEYS					(pVersion)
		,MOXIE_BH_Best_Keys			(pVersion)
		,MOXIE_BH_Stats_Keys		(pVersion)
		,MOXIE_BH_Contacts_Keys (pVersion)
		,promote								(pversion,'moxie').New2Built
		,promote								(pversion,'moxie').Built2QA
		,if(pShouldDkcKeys = true
			,DKC_Keys								(pServer,pBusMount,pOverwrite,,'DkcAllKeysInfo')
		)
	);

	return do_all;

end;