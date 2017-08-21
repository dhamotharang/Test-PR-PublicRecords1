
import versioncontrol, _control;

export DKC_Employment_Keys(
	
	 string		pServer			= _control.IPAddress.edata14a
	,string		pMount			= '/paw_16/'
	,boolean	pOverwrite	= false
	,string		pFilter			= ''

) := 
function

	dAllKeys := Moxie_Keynames().paw.dAll_filenames	;

	filter				:= if(pFilter = ''	,true
																		,regexfind(pFilter,dAllKeys.templatename,nocase)
										);

	dkc_keys := fGetReadyForDespray(dAllKeys(filter), ,pMount,,pOverwrite);

	return versioncontrol.fDkcKeys(dkc_keys,,,'DkcPawKeysInfo',pOverwrite);

end;
