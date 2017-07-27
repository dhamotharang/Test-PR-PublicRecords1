import ut;

pre := ut.sf_maintbuilding('~thor_Data400::base::govdata_fdic_bdid');

ut.MAC_SK_BuildProcess_v2(govdata.key_fdic_bdid,'~thor_data400::key::govdata_fdic_bdid',do1);
ut.MAC_SK_Move_v2('~thor_data400::key::govdata_fdic_bdid','Q',do2,2);

post := ut.sf_maintbuilt('~thor_data400::base::govdata_fdic_bdid');

export proc_build_fdic_key := sequential(pre,do1,do2,post);
