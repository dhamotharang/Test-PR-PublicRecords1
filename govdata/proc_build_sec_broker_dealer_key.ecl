import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::sec_broker_dealer');

ut.MAC_SK_BuildProcess_v2(govdata.key_sec_broker_dealer_BDID,'~thor_data400::key::sec_broker_dealer_bdid',do1);
ut.mac_sk_move_v2('~thor_data400::key::sec_broker_dealer_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::sec_broker_dealer');

export proc_build_sec_broker_dealer_key := sequential(pre,do1,do2,post);
