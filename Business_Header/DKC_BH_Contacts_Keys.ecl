
import versioncontrol, _control;

export DKC_BH_Contacts_Keys(
	
	 string		pServer			= _control.IPAddress.edata14a
	,string		pMount			= '/bus_hdr_16/'
	,boolean	pOverwrite	= false
	,string		pFilter			= ''

) := 
function

	all_keys := Moxie_Keynames().Business_Contacts.dAll_filenames	;

	filter			:= if(pFilter = ''	,true
																	,regexfind(pFilter,all_keys.templatename,nocase)
								);

	dkc_keys := fGetReadyForDespray(all_keys(filter), pMount,,,pOverwrite);

	return versioncontrol.fDkcKeys(dkc_keys,,,'DkcBusinessContactsKeysInfo',pOverwrite);

end;