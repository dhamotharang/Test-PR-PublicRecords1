import ut;

a := ut.SF_MaintBuilding('~thor_data400::base::codes_v3');

ut.MAC_SK_BuildProcess(key_prep_codes_v3,'~hthor::key::codes_v3','~hthor::key::codes_v3',b,3,true)

c := ut.SF_MaintBuilt('~thor_data400::base::codes_v3');
		
export proc_build_keys := if (fileservices.getsuperfilesubname('~thor_data400::base::codes_v3',1) = fileservices.getsuperfilesubname('~thor_data400::base::codes_v3_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(a,b,c));