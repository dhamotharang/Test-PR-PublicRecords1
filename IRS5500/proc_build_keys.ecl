import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::irs5500');

ut.MAC_SK_BuildProcess_v2(irs5500.key_irs5500_bdid,'~thor_data400::key::irs5500_bdid',do1);
ut.MAC_SK_BuildProcess_v2(IRS5500.Key_LinkIds.Key,'~thor_data400::key::irs5500_linkIDs',do2);

ut.mac_sk_move_v2('~thor_data400::key::irs5500_bdid','Q',do3,3);
ut.mac_sk_move_v2('~thor_data400::key::irs5500_linkIDs','Q',do4,3);

post := ut.SF_MaintBuilt('~thor_data400::base::irs5500');

export proc_build_keys := sequential(pre,parallel(do1,do2),parallel(do3,do4),post);