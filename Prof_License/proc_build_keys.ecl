import ut;

a := sequential(
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount('~thor_Data400::base::prof_licenses_BUILDING') > 0,
			output('Nothing added to BUILDING Superfile'),
			fileservices.addsuperfile('~thor_Data400::base::prof_licenses_BUILDING','~thor_data400::base::prof_licenses',0,true)),
		fileservices.finishsuperfiletransaction()
		);

ut.MAC_SK_BuildProcess(prof_license.key_prep_did,'~thor_Data400::key::prolicense_did','~thor_Data400::key::prolicense_did',b)
ut.MAC_SK_BuildProcess(prof_license.Key_prep_licenseNum,'~thor_data400::key::proflic_licensenum','~thor_data400::key::proflic_licensenum',c)
ut.mac_sk_buildprocess_v2(prof_license.key_proflic_bdid,'~thor_data400::key::proflic_bdid',d);

e := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::base::prof_licenses_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::prof_licenses_BUILT','~thor_data400::base::prof_licenses_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::prof_licenses_BUILDING'),
		fileservices.finishsuperfiletransaction()
		);
		

export proc_build_keys :=  if (fileservices.getsuperfilesubname('~thor_data400::base::prof_licenses',1) = fileservices.getsuperfilesubname('~thor_data400::base::prof_licenses_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(a,b,c,d,e));