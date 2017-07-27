import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::or_workers_comp');

ut.mac_sk_buildprocess_v2(govdata.key_or_workers_comp_bdid,'~thor_data400::key::or_workers_comp_bdid',do1);
ut.mac_sk_move_v2('~thor_data400::key::or_workers_comp_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::or_workers_comp');

export proc_build_or_workers_comp_key := sequential(pre,do1,do2,post);
