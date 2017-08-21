import ut, roxiekeybuild, promotesupers;

roxiekeybuild.mac_sk_move('~thor_data400::key::dea_did','Q',do1);
promotesupers.mac_sk_move_v2('~thor_data400::key::dea_bdid','Q',do2,2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dea::@version@::reg_num','Q',do3)


export proc_accept_sk_To_QA := sequential(do1,do2,do3);