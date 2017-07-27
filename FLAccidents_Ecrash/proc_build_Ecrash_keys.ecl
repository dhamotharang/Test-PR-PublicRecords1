import ut, RoxieKeyBuild,flaccidents;

export proc_build_ecrash_keys(string filedate) := function

//build non autokeys
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash0
                     ,'~thor_data400::key::ecrash::' +filedate+'::ecrash0'
    									   ,'~thor_data400::key::ecrash0',bk0,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash1
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash1'
					  			       ,'~thor_data400::key::ecrash1',bk1,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash2v
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash2v'
					  			       ,'~thor_data400::key::ecrash2v',bk2,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash3v
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash3v'
					  			       ,'~thor_data400::key::ecrash3v',bk3,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash4
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash4'
	 				  			       ,'~thor_data400::key::ecrash4',bk4,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash5
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash5'
					  			       ,'~thor_data400::key::ecrash5',bk5,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash6
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash6'
					  			       ,'~thor_data400::key::ecrash6',bk6,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash7
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash7'
					  			       ,'~thor_data400::key::ecrash7',bk7,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash8
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash8'
					  			       ,'~thor_data400::key::ecrash8',bk8,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash_Did
									   ,'~thor_data400::key::ecrash::' +filedate+'::did'
					  			       ,'~thor_data400::key::ecrash_did',bk_did,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash_AccNbr
									   ,'~thor_data400::key::ecrash::' +filedate+'::accnbr'
					                   ,'~thor_data400::key::ecrash_accnbr',bk_accnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash_Bdid
									   ,'~thor_data400::key::ecrash::' +filedate+'::bdid'
					                   ,'~thor_data400::key::ecrash_bdid',bk_bdid,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash_DLNbr
									   ,'~thor_data400::key::ecrash::' +filedate+'::dlnbr'
					  			       ,'~thor_data400::key::ecrash_dlnbr',bk_dlnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash_TagNbr
									   ,'~thor_data400::key::ecrash::' +filedate+'::tagnbr'
					      			   ,'~thor_data400::key::ecrash_tagnbr',bk_tagnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash_VIN
									   ,'~thor_data400::key::ecrash::' +filedate+'::vin'
					  			       ,'~thor_data400::key::ecrash_vin',bk_vin,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash_vin7
									   ,'~thor_data400::key::ecrash::' +filedate+'::vin7'
					  			       ,'~thor_data400::key::ecrash_vin7',bk_vin7,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash_dol
									   ,'~thor_data400::key::ecrash::' +filedate+'::dol'
					  			       ,'~thor_data400::key::ecrash_dol',bk_dol,2);	
build_keys := parallel(bk0,bk1,bk3,bk5,bk6,bk7,bk8,bk_did,bk_accnbr,bk_bdid,bk_dlnbr,bk_tagnbr,bk_vin,bk_dol);

// move keys to built
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash0'
                                  ,'~thor_data400::key::ecrash0'
								  ,move1);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash1'
                                  ,'~thor_data400::key::ecrash1'
								  ,move2);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash2v'
                                  ,'~thor_data400::key::ecrash2v'
								  ,move3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash3v'
                                  ,'~thor_data400::key::ecrash3v'
								  ,move4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash4'
                                  ,'~thor_data400::key::ecrash4'
								  ,move5);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash5'
                                  ,'~thor_data400::key::ecrash5'
								  ,move6);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash6'
                                  ,'~thor_data400::key::ecrash6'
								  ,move7);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash7'
                                  ,'~thor_data400::key::ecrash7'
								  ,move8);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash8'
                                  ,'~thor_data400::key::ecrash8'
								  ,move9);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::did'
                                  ,'~thor_data400::key::ecrash_did'
								  ,move10);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::accnbr'
                                  ,'~thor_data400::key::ecrash_accnbr'
								  ,move11);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::bdid'
                                  ,'~thor_data400::key::ecrash_bdid'
								  ,move12);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::dlnbr'
                                  ,'~thor_data400::key::ecrash_dlnbr'
								  ,move13);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::tagnbr'
                                  ,'~thor_data400::key::ecrash_tagnbr'
								  ,move14);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::vin'
                                  ,'~thor_data400::key::ecrash_vin'
								  ,move15);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::vin7'
                                  ,'~thor_data400::key::ecrash_vin7'
								  ,move17);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::dol'
                                  ,'~thor_data400::key::ecrash_dol'
								  ,move18);
move_build_keys := parallel(move1,move2,move4,move6,move7,move8,move9,move10
							,move11,move12,move13,move14,move15,move18);

// Move keys to QA
ut.MAC_SK_Move('~thor_data400::key::ecrash0',    'Q', moveq1);
ut.MAC_SK_Move('~thor_data400::key::ecrash1',    'Q', moveq2);
ut.MAC_SK_Move('~thor_data400::key::ecrash2v',   'Q', moveq3);
ut.MAC_SK_Move('~thor_data400::key::ecrash3v',   'Q', moveq4);
ut.MAC_SK_Move('~thor_data400::key::ecrash4',    'Q', moveq5);
ut.MAC_SK_Move('~thor_data400::key::ecrash5',    'Q', moveq6);
ut.MAC_SK_Move('~thor_data400::key::ecrash6',    'Q', moveq7);
ut.MAC_SK_Move('~thor_data400::key::ecrash7',    'Q', moveq8);
ut.MAC_SK_Move('~thor_data400::key::ecrash8',    'Q', moveq9);
ut.MAC_SK_Move('~thor_data400::key::ecrash_did', 'Q', moveq10);
ut.MAC_SK_Move('~thor_data400::key::ecrash_accnbr','Q', moveq11);
ut.MAC_SK_Move('~thor_data400::key::ecrash_bdid',  'Q', moveq12);
ut.MAC_SK_Move('~thor_data400::key::ecrash_dlnbr', 'Q', moveq13);
ut.MAC_SK_Move('~thor_data400::key::ecrash_tagnbr','Q', moveq14);
ut.MAC_SK_Move('~thor_data400::key::ecrash_vin',   'Q', moveq15);
ut.MAC_SK_Move('~thor_data400::key::ecrash_vin7',   'Q', moveq17);
ut.MAC_SK_Move('~thor_data400::key::ecrash_dol',   'Q', moveq18);
move_qa_keys := parallel(moveq1,moveq2,moveq4,moveq6,moveq7,moveq8,moveq9,moveq10
							,moveq11,moveq12,moveq13,moveq14,moveq15,moveq18);


// email_send_list := 'tgibson@seisint.com';

// RoxieKeyBuild.Mac_Daily_Email_Local('ecrash'
                                   // ,'SUCC'
								   // ,filedate
								   // ,send_succ_msg
								   // ,email_send_list);
// RoxieKeyBuild.Mac_Daily_Email_Local('ecrash'
                                   // ,'FAIL'
								   // ,filedate
								   // ,send_fail_msg
								   // ,email_send_list);

do_all:= sequential(
					flaccidents_ecrash.Proc_build_ecrash_autokey(filedate) //build auto keys
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