import ut;

ut.MAC_SK_BuildProcess(key_prep_liens_did,'~thor_data400::key::liens_did', 
								  '~thor_data400::key::liens_did',bk1)
ut.MAC_SK_BuildProcess(key_prep_liens_bdid,'~thor_data400::key::liens_bdid',
								   '~thor_data400::key::liens_bdid',bk2)
ut.MAC_SK_BuildProcess(key_prep_liens_rmsid,'~thor_data400::key::liens_rmsid',
								    '~thor_data400::key::liens_rmsid',bk3)
ut.MAC_SK_BuildProcess(key_prep_liens_st_case,'~thor_data400::key::liens_st_case',
								      '~thor_data400::key::liens_st_case',bk4)

ut.mac_sk_buildprocess_v2(key_liens_plaintiffname,'~thor_data400::key::liens_plaintiffname',bk5);
ut.MAC_SK_BuildProcess_v2(doxie.key_liens_bdid_pl,'~thor_data400::key::liens_bdid_pl',bk6);
							
ut.MAC_SK_Move('~thor_data400::key::liens_did','Q',mv1)
ut.MAC_SK_Move('~thor_data400::key::liens_bdid','Q',mv2)
ut.MAC_SK_Move('~thor_data400::key::liens_rmsid','Q',mv3)
ut.MAC_SK_Move('~thor_data400::key::liens_st_case','Q',mv4)
ut.mac_sk_move_v2('~thor_data400::key::liens_plaintiffname','Q',mv5,2);
ut.mac_sk_move_v2('~thor_data400::key::liens_bdid_pl','Q',mv6,2);

doxie.Mac_Daily_Email('LIENS','SUCC',send_succ_msg,bankrupt.Spray_Notification_Email_Address);
doxie.Mac_Daily_Email('LIENS','FAIL',send_fail_msg,bankrupt.Spray_Notification_Email_Address);

export proc_build_liens_keys := sequential(parallel(bk1,bk2,bk3,bk4,bk5,bk6),
                                           parallel(mv1,mv2,mv3,mv4,mv5,mv6)) :
								   success(send_succ_msg),
								   failure(send_fail_msg);
                              
