import ut;

pre := ut.sf_maintbuilding('~thor_data400::base::vickers_13d13g_base');

ut.MAC_SK_BuildProcess_v2(vickers.Key_13d13g_BDID,'~thor_data400::key::vickers_13d13g_bdid',do1);
ut.mac_sk_move_v2('~thor_data400::key::vickers_13d13g_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::vickers_13d13g_base');

export proc_build_13d13g_key := sequential(pre,do1,do2,post);
