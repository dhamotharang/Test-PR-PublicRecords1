import ut;

pre1 := ut.SF_MaintBuilding('~thor_Data400::base::ska_nixie');
pre2 := ut.SF_MaintBuilding('~thor_Data400::base::ska_verified');

ut.MAC_SK_BuildProcess_v2(busdata.Key_SKA_Nixie_BDID,'~thor_data400::key::ska_nixie_bdid',do1);
ut.MAC_SK_BuildProcess_v2(busdata.Key_SKA_Verified_BDID,'~thor_Data400::key::ska_verified_bdid',do2);

ut.mac_sk_move_v2('~thor_data400::key::ska_nixie_bdid','Q',do3,2);
ut.mac_sk_move_v2('~thor_data400::key::ska_verified_bdid','Q',do4,2);

post1 := ut.SF_MaintBuilt('~thor_data400::base::ska_nixie');
post2 := ut.SF_MaintBuilt('~thor_data400::base::ska_verified');

export proc_build_ska_keys := sequential(sequential(pre1,do1,do3,post1),sequential(pre2,do2,do4,post2));
