import versioncontrol, _control;

export DKC_Keys(
	
	 string		pServer			= _control.IPAddress.edata14a
	,string		pBusMount		= '/bus_hdr_3210/'
	,boolean	pOverwrite	= false
	,string		pFilter			= ''
	,string		pOutputNAme	= 'DkcKeysInfo'
	,boolean	pIsTesting	= false

) := 
function

	all_keys := 	Moxie_Keynames().dAll_filenames;

	filter			:= if(pFilter = ''	,true
																	,regexfind(pFilter,all_keys.templatename,nocase)
								);

	dkc_keys := fGetReadyForDespray(all_keys(filter), pBusMount,pServer,pOverwrite);

	return versioncontrol.fDkcKeys(dkc_keys,,,pOutputNAme,pOverwrite,pIsTesting);

end;