import ut, RoxieKeyBuild;

export proc_build_ntlcrash_keys(string filedate) := function

//build non autokeys
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash0
                     ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash0'
    									   ,'~thor_data400::key::ntlcrash0',bk0,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash1
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash1'
					  			       ,'~thor_data400::key::ntlcrash1',bk1,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash2v
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash2v'
					  			       ,'~thor_data400::key::ntlcrash2v',bk2,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash3v
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash3v'
					  			       ,'~thor_data400::key::ntlcrash3v',bk3,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash4
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash4'
	 				  			       ,'~thor_data400::key::ntlcrash4',bk4,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash5
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash5'
					  			       ,'~thor_data400::key::ntlcrash5',bk5,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash6
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash6'
					  			       ,'~thor_data400::key::ntlcrash6',bk6,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash7
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash7'
					  			       ,'~thor_data400::key::ntlcrash7',bk7,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash8
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash8'
					  			       ,'~thor_data400::key::ntlcrash8',bk8,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash9
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash9'
					  			       ,'~thor_data400::key::ntlcrash9',bk9,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash_Did
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::did'
					  			       ,'~thor_data400::key::ntlcrash_did',bk_did,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash_AccNbr
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::accnbr'
					                   ,'~thor_data400::key::ntlcrash_accnbr',bk_accnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash_Bdid
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::bdid'
					                   ,'~thor_data400::key::ntlcrash_bdid',bk_bdid,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash_DLNbr
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::dlnbr'
					  			       ,'~thor_data400::key::ntlcrash_dlnbr',bk_dlnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash_TagNbr
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::tagnbr'
					      			   ,'~thor_data400::key::ntlcrash_tagnbr',bk_tagnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_ntlcrash_VIN
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::vin'
					  			       ,'~thor_data400::key::ntlcrash_vin',bk_vin,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents.Key_ntlcrash_vin7
									   ,'~thor_data400::key::ntlcrash::' +filedate+'::vin7'
					  			       ,'~thor_data400::key::ntlcrash_vin7',bk_vin7,2);									   
build_keys := parallel(bk0,bk1,bk3,bk5,bk6,bk7,bk8,bk9,bk_did,bk_accnbr,bk_bdid,bk_dlnbr,bk_tagnbr,bk_vin);

// move keys to built
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash0'
                                  ,'~thor_data400::key::ntlcrash0'
								  ,move1);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash1'
                                  ,'~thor_data400::key::ntlcrash1'
								  ,move2);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash2v'
                                  ,'~thor_data400::key::ntlcrash2v'
								  ,move3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash3v'
                                  ,'~thor_data400::key::ntlcrash3v'
								  ,move4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash4'
                                  ,'~thor_data400::key::ntlcrash4'
								  ,move5);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash5'
                                  ,'~thor_data400::key::ntlcrash5'
								  ,move6);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash6'
                                  ,'~thor_data400::key::ntlcrash6'
								  ,move7);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash7'
                                  ,'~thor_data400::key::ntlcrash7'
								  ,move8);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash8'
                                  ,'~thor_data400::key::ntlcrash8'
								  ,move9);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::ntlcrash9'
                                  ,'~thor_data400::key::ntlcrash9'
								  ,move16);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::did'
                                  ,'~thor_data400::key::ntlcrash_did'
								  ,move10);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::accnbr'
                                  ,'~thor_data400::key::ntlcrash_accnbr'
								  ,move11);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::bdid'
                                  ,'~thor_data400::key::ntlcrash_bdid'
								  ,move12);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::dlnbr'
                                  ,'~thor_data400::key::ntlcrash_dlnbr'
								  ,move13);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::tagnbr'
                                  ,'~thor_data400::key::ntlcrash_tagnbr'
								  ,move14);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::vin'
                                  ,'~thor_data400::key::ntlcrash_vin'
								  ,move15);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ntlcrash::' +filedate+'::vin7'
                                  ,'~thor_data400::key::ntlcrash_vin7'
								  ,move17);
move_build_keys := parallel(move1,move2,move4,move6,move7,move8,move9,move16,move10
							,move11,move12,move13,move14,move15);

// Move keys to QA
ut.MAC_SK_Move('~thor_data400::key::ntlcrash0',    'Q', moveq1);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash1',    'Q', moveq2);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash2v',   'Q', moveq3);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash3v',   'Q', moveq4);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash4',    'Q', moveq5);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash5',    'Q', moveq6);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash6',    'Q', moveq7);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash7',    'Q', moveq8);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash8',    'Q', moveq9);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash9',    'Q', moveq16);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash_did', 'Q', moveq10);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash_accnbr','Q', moveq11);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash_bdid',  'Q', moveq12);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash_dlnbr', 'Q', moveq13);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash_tagnbr','Q', moveq14);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash_vin',   'Q', moveq15);
ut.MAC_SK_Move('~thor_data400::key::ntlcrash_vin7',   'Q', moveq17);
move_qa_keys := parallel(moveq1,moveq2,moveq4,moveq6,moveq7,moveq8,moveq9,moveq16,moveq10
							,moveq11,moveq12,moveq13,moveq14,moveq15);


// email_send_list := 'tgibson@seisint.com';

// RoxieKeyBuild.Mac_Daily_Email_Local('ntlcrash'
                                   // ,'SUCC'
								   // ,filedate
								   // ,send_succ_msg
								   // ,email_send_list);
// RoxieKeyBuild.Mac_Daily_Email_Local('ntlcrash'
                                   // ,'FAIL'
								   // ,filedate
								   // ,send_fail_msg
								   // ,email_send_list);

do_all:= sequential(
					FlAccidents.Proc_build_Ntl_autokey(filedate) //build auto keys
					,build_keys
					,move_build_keys
					,move_qa_keys
					,bk_vin7
					,move17
					,moveq17
					,bk2
					,move3
					,moveq3
					,bk4
					,move5
					,moveq5); 
					//: success(send_succ_msg),failure(send_fail_msg);
return do_all;
												   
end;