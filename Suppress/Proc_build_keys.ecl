import ut;

a := ut.SF_MaintBuilding('~thor_data400::in::blackphonelist');

ut.MAC_SK_BuildProcess(key_pullPhone,'~thor_data400::key::blackphonelist',
							  '~thor_data400::key::blackphonelist',b,3,true)

c := ut.SF_MaintBuilt('~thor_data400::in::blackphonelist');

export proc_build_keys := 
if (fileservices.getsuperfilesubname('~thor_data400::in::blackphonelist',1) = 
    fileservices.getsuperfilesubname('~thor_data400::in::blackphonelist_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(a,b,c));