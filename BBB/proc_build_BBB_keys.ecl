#workunit('name', 'Build BBB Keys');

import ut;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::BBB');
ut.MAC_SK_BuildProcess_v2(BBB.Key_BBB_BDID,'~thor_data400::key::bbb_bdid',do1);
ut.mac_sk_move_v2('~thor_data400::key::bbb_bdid','Q',do2,2);
post1 := ut.SF_MaintBuilt('~thor_data400::base::BBB');

pre2 := ut.SF_MaintBuilding('~thor_data400::base::BBB_Non_Member');
ut.MAC_SK_BuildProcess_v2(BBB.Key_BBB_Non_Member_BDID,'~thor_data400::key::bbb_non_member_bdid',do3);
ut.mac_sk_move_v2('~thor_data400::key::bbb_non_member_bdid','Q',do4,2);
post2 := ut.SF_MaintBuilt('~thor_data400::base::BBB_Non_Member');


export proc_build_BBB_keys := sequential(pre1,do1,do2,post1,pre2,do3,do4,post2);
