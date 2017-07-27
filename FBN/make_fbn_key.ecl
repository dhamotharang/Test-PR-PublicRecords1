import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::fbn');

ut.MAC_SK_BuildProcess_v2(fbn.key_fbn_bdid,'~thor_data400::key::fbn_bdid',do1)
ut.MAC_SK_Move_v2('~thor_Data400::key::fbn_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::fbn');

export make_fbn_key := sequential(pre,do1,do2,post);
