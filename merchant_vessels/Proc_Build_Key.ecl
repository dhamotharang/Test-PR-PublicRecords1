import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::merch_vessels');
		
ut.MAC_SK_BuildProcess(key_prep_merchvessels_did,'~thor_Data400::key::merchant_vessel_did_','~thor_data400::key::merchant_vessel_did',foo,2)
ut.mac_sk_buildprocess_v2(key_merchant_vessel_BDID,'~thor_data400::key::merchant_vessel_bdid',do1);
ut.MAC_SK_BuildProcess_v2(key_merch_vessel_did_to_vid,'~thor_data400::key::merchant_vessel_did2vid',do2);
ut.MAC_SK_BuildProcess_v2(key_merch_vessel_HullId,'~thor_data400::key::merchant_vessel_HullNum',do3);
ut.MAC_SK_BuildProcess_v2(key_merch_vessel_Vname,'~thor_data400::key::merchant_vessel_vname',do4);
ut.MAC_SK_BuildProcess_v2(key_merch_vessel_vid,'~thor_data400::key::merchant_vessel_vid',do5);

post := ut.SF_MaintBuilt('~thor_data400::base::merch_vessels');

export Proc_Build_Key := if (fileservices.getsuperfilesubname('~thor_data400::base::merch_vessels',1) = fileservices.getsuperfilesubname('~thor_data400::base::merch_vessels_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(pre,foo,do1,do2,do3,do4,do5,post));