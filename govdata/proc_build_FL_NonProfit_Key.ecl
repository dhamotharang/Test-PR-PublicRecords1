import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::fl_nonprofit_bdid');

ut.MAC_SK_buildprocess_v2(govdata.key_FL_NonProfit_BDID,'~thor_data400::key::fl_nonprofit_bdid',do1);
ut.MAC_SK_Move_v2('~thor_data400::key::fl_nonprofit_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::fl_nonprofit_bdid');

export proc_build_FL_NonProfit_Key := sequential(pre,do1,do2,post);
