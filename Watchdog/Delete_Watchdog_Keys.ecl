import Watchdog,lib_keylib,lib_fileservices,ut;

ut.Mac_Delete_File('~thor_data400::key::watchdog_moxie_nonglb_nonutility.did',key1);
ut.Mac_Delete_File('~thor_data400::key::watchdog_moxie.did',key2);
ut.Mac_Delete_File('~thor_data400::key::watchdog_moxie_nonglb.did',key3);
ut.Mac_Delete_File('~thor_data400::key::watchdog_moxie_nonutility.did',key4);
ut.Mac_Delete_File('~thor_data400::key::watchdog_moxie_old_did.did',key5);

export Delete_Watchdog_Keys := sequential(key1,key2,key3,key4,key5);