import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::gov_phones');

ut.MAC_SK_BuildProcess_v2(govdata.key_gov_phones_bdid,'~thor_data400::key::gov_phones_bdid',do1);
ut.MAC_SK_Move_v2('~thor_data400::key::gov_phones_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_Data400::base::gov_phones');

export proc_build_gov_phones_key := sequential(pre,do1,do2,post);
