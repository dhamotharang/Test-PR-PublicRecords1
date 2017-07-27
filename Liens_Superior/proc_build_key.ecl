import ut;

// pre := sequential(
		// fileservices.startsuperfiletransaction(),
		// if (fileservices.getsuperfilesubcount('~thor_Data400::base::superior_liens_did_BUILDING') > 0,
			// output('Nothing added to BUILDING Superfile'),
			// fileservices.addsuperfile('~thor_Data400::base::superior_liens_did_BUILDING', '~thor_data400::base::superior_liens_did', 0, true)),
		// fileservices.finishsuperfiletransaction()
		// );
		

ut.MAC_SK_BuildProcess_v2(liens_superior.key_prep_did, '~thor_data400::key::superior_liens_did', a,, false)
ut.MAC_SK_BuildProcess_v2(liens_superior.key_bdid, '~thor_data400::key::superior_liens_bdid', b,, false)


// h := sequential(
		// fileservices.startsuperfiletransaction(),
		// fileservices.clearsuperfile('~thor_data400::base::superior_liens_did_BUILT'),
		// fileservices.addsuperfile('~thor_data400::base::superior_liens_did_BUILT','~thor_data400::base::superior_liens_did_BUILDING', 0, true),
		// fileservices.clearsuperfile('~thor_Data400::base::superior_liens_did_BUILDING'),
		// fileservices.finishsuperfiletransaction()
		// );

//export proc_build_key := sequential(liens_superior.did_superior_liens, parallel(a), liens_superior.Proc_Accept_SK_To_QA);
export proc_build_key := sequential(liens_superior.did_superior_liens, parallel(a,b), liens_superior.Proc_Accept_SK_To_QA);