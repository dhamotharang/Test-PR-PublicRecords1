export DKC_WatchDog_Keys(volume_name) := 
macro

#uniquename(DestinationIP)
#uniquename(key1)
#uniquename(key2)
#uniquename(key3)
#uniquename(key4)
#uniquename(key5)

#workunit('name', 'DKC Watchdog Keys');

%DestinationIP% := '192.168.0.39';

%key1% := lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie_nonglb_nonutility.did',%DestinationIP%,volume_name+'/watchdog_non_glb_non_utility.match.key',,,,TRUE);
%key2% := lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie.did',%DestinationIP%,volume_name+'/watchdog.match.key',,,,TRUE);
%key3% := lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie_nonglb.did',%DestinationIP%,volume_name+'/watchdog_non_glb.match.key',,,,TRUE);
%key4% := lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie_nonutility.did',%DestinationIP%,volume_name+'/watchdog_non_utility.match.key',,,,TRUE);
%key5% := lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie_old_did.did',%DestinationIP%,volume_name+'/watchdog_old_new_did.match.key',,,,TRUE);

sequential(%key1%,%key2%,%key3%,%key4%,%key5%);

endmacro;