import ut;

pre := sequential(
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount('~thor_Data400::base::bk_search_did_BUILDING') > 0,
			output('Nothing added to BUILDING Superfile'),
			fileservices.addsuperfile('~thor_Data400::base::bk_search_did_BUILDING','~thor_data400::base::bankrupt_search',0,true)),
		fileservices.finishsuperfiletransaction()
		);

ut.MAC_SK_BuildProcess_v2(bankrupt.key_prep_bankrupt_did,'~thor_Data400::key::bkrupt_did',a,,true)
ut.MAC_SK_BuildProcess_v2(bankrupt.key_prep_bankrupt_casenum,'~thor_data400::key::bkrupt_casenum',b,,true)
ut.MAC_SK_BuildProcess_v2(bankrupt.key_prep_bkrupt_didslim,'~thor_Data400::key::bankrupt_didslim',c,,true)
ut.MAC_SK_BuildProcess_v2(bankrupt.key_prep_bankrupt_full,'~thor_data400::key::bkrupt_full',d,,true)
ut.mac_sk_buildprocess_v2(bankrupt.key_bankrupt_bdid,'~thor_data400::key::bankrupt_bdid',e)

h := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::base::bk_Search_did_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::bk_Search_did_BUILT','~thor_data400::base::bk_Search_did_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::bk_Search_did_BUILDING'),
		fileservices.finishsuperfiletransaction()
		);

export proc_build_key := if (fileservices.getsuperfilesubname('~thor_data400::base::bankrupt_Search',1) = fileservices.getsuperfilesubname('~thor_data400::base::bk_Search_did_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(pre,parallel(a,b,c,d,e),h,bankrupt.Proc_Accept_SK_To_QA));