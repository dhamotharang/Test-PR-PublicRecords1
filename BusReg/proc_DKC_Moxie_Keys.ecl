import versioncontrol, _control;

export proc_DKC_Moxie_Keys(
	
	 string		pServer			= _control.IPAddress.edata14a
	,string		pMount			= '/bus_reg_3210/busreg/'
	,boolean	pOverwrite	= false
	,string		pFilter			= ''
	,string		pOutputNAme	= 'DkcKeysInfo'
	,boolean	pIsTesting	= false

) := 
function

	all_keys := 	Keynames().Moxie.dAll_filenames;

	filter			:= if(pFilter = ''	,true
																	,regexfind(pFilter,all_keys.templatename,nocase)
								);

	dkc_keys := versioncontrol.fGetReadyForDespray(all_keys(filter), pMount,pServer,pOverwrite);

	return versioncontrol.fDkcKeys(dkc_keys,,,pOutputNAme,pOverwrite,pIsTesting);

end;