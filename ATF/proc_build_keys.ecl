import ut;

a := sequential(
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount('~thor_Data400::base::atf_firearms_explosives_BUILDING') > 0,
			output('Nothing added to BUILDING Superfile'),
			fileservices.addsuperfile('~thor_Data400::base::atf_firearms_explosives_BUILDING','~thor_data400::base::atf_firearms_explosives',0,true)),
		fileservices.finishsuperfiletransaction()
		);

ut.MAC_SK_BuildProcess_v2(atf.key_prep_atf_did,'~thor_Data400::key::atf_firearms_did',b)
ut.MAC_SK_BuildProcess_v2(atf.key_prep_atf_lnum,'~thor_data400::key::atf_firearms_lnum',c)
ut.MAC_SK_BuildProcess_v2(atf.key_prep_atf_trad,'~thor_data400::key::atf_firearms_trad',d)
ut.MAC_SK_BuildProcess_v2(atf.key_prep_atf_records,'~thor_data400::key::atf_firearms_records',e)

j := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::base::atf_firearms_explosives_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::atf_firearms_explosives_BUILT','~thor_data400::base::atf_firearms_explosives_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::atf_firearms_explosives_BUILDING'),
		fileservices.finishsuperfiletransaction()
		);
		
export proc_build_keys := if (fileservices.getsuperfilesubname('~thor_data400::base::atf_firearms_explosives',1) = fileservices.getsuperfilesubname('~thor_data400::base::atf_firearms_explosives_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(a,parallel(b,c,d,e),j));