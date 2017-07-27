import ut;

pre := ut.SF_MaintBuilding('~thor_Data400::base::ms_workers_comp');

ut.MAC_SK_BuildProcess_v2(govdata.key_ms_workers_comp_BDID,'~thor_data400::key::ms_workers_comp_bdid',do1);
ut.MAC_SK_Move_v2('~thor_data400::key::ms_workers_comp_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::ms_workers_comp');

export proc_build_ms_workers_comp_key := sequential(pre,do1,do2,post);
