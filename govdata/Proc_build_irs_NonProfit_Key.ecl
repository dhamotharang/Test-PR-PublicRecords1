import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::irs_nonProfit');

ut.mac_sk_buildprocess_v2(govdata.Key_IRS_NonProfit_BDID,'~thor_data400::key::irs_nonprofit_bdid',do1);
ut.mac_sk_move_v2('~thor_data400::key::irs_nonprofit_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_Data400::base::irs_nonprofit');

export Proc_build_irs_NonProfit_Key := sequential(pre,do1,do2,post);
