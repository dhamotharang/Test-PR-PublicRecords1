import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::credit_unions');

ut.MAC_SK_BuildProcess_v2(busdata.key_credit_union_bdid,'~thor_data400::key::credit_unions_bdid',do1);
ut.mac_sk_move_v2('~thor_data400::key::credit_unions_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_Data400::base::credit_unions');

export proc_build_Credit_union_keys := sequential(pre,do1,do2,post);
