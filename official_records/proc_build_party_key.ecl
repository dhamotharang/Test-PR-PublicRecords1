import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::official_recs_party');

ut.MAC_SK_BuildProcess_v2(key_officialrecs_party_bdid,'~thor_data400::key::official_recs_party_bdid',do1);
ut.mac_sk_buildprocess_v2(key_official_recs_did,'~thor_data400::key::official_recs_did',do2);
ut.MAC_SK_BuildProcess_v2(key_official_records_ORKey,'~thor_Data400::key::official_recs_ork',do3);

ut.MAC_SK_Move_v2('~thor_data400::key::official_recs_party_bdid','Q',do4,2);
ut.MAC_SK_Move_v2('~thor_data400::key::official_recs_did','Q',do5,2);
ut.MAC_SK_Move_v2('~thor_Data400::key::official_recs_ork','Q',do6,2);

post := ut.SF_MaintBuilt('~thor_data400::base::official_recs_party');

export proc_build_party_key := sequential(pre,do1,do2,do3,do4,do5,do6,post);

