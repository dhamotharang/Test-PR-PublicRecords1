#workunit('name','Watchdog DKC Keys')

import _control;

export dkc_watchdog_moxie_keys(string moxie_server, string moxie_mount) := function

  new_moxie_server := map(
							moxie_server = 'edata14' => _control.IPAddress.edata14,
							moxie_server = 'edata12' => _control.IPAddress.edata12,
							moxie_server = 'edata10' => _control.IPAddress.edata10,
							moxie_server
						 );
						 
  key1 := fileservices.dkc('~thor_data400::key::watchdog_moxie.did',new_moxie_server,moxie_mount+'/watchdog.match.key',,,,TRUE);
  key2 := fileservices.dkc('~thor_data400::key::watchdog_moxie_nonglb.did',new_moxie_server,moxie_mount+'/watchdog_non_glb.match.key',,,,TRUE);
  key3 := fileServices.dkc('~thor_data400::key::watchdog_moxie_nonglb_nonutility.did',new_moxie_server,moxie_mount+'/watchdog_non_glb_non_utility.match.key',,,,TRUE);
  key4 := fileServices.dkc('~thor_data400::key::watchdog_moxie_nonutility.did',new_moxie_server,moxie_mount+'/watchdog_non_utility.match.key',,,,TRUE);
  key5 := fileServices.dkc('~thor_data400::key::watchdog_moxie_old_did.did',new_moxie_server,moxie_mount+'/watchdog_old_new_did.match.key',,,,TRUE);

  return sequential(key1,key2/*,key3,key4,key5*/);
end;