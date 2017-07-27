import ut;

pre := ut.SF_MaintBuilding('~thor_Data400::base::fl_fbn_base');

ut.mac_sk_buildprocess_v2(govdata.Key_FL_FBN_BDID,'~thor_data400::key::fl_fbn_bdid',do1);
ut.MAC_SK_Move_v2('~thor_Data400::key::fl_fbn_bdid','Q',do2,2);

post := ut.sf_maintbuilt('~thor_Data400::base::Fl_FBN_base');

export proc_build_FL_FBN_Key := sequential(pre,do1,do2,post);
