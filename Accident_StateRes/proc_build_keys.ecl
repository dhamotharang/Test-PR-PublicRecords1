import ut, RoxieKeyBuild;

export proc_build_keys(string filedate) := function

//build non autokeys
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Accident_StateRes.Key_StResInput
                     ,'~thor_data400::key::accident_state_restrictions::' +filedate+'::input'
    									   ,'~thor_data400::key::accident_state_restrictions::input',bk0,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Accident_StateRes.Key_StResReport
									   ,'~thor_data400::key::accident_state_restrictions::' +filedate+'::report'
					  			       ,'~thor_data400::key::accident_state_restrictions::report',bk1,2);

build_keys := parallel(bk0,bk1);

// move keys to built
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::accident_state_restrictions::' +filedate+'::input'
                                  ,'~thor_data400::key::accident_state_restrictions::input'
								  ,move1);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::accident_state_restrictions::' +filedate+'::report'
                                  ,'~thor_data400::key::accident_state_restrictions::report'
								  ,move2);

move_build_keys := parallel(move1,move2);

// Move keys to QA
ut.MAC_SK_Move('~thor_data400::key::accident_state_restrictions::input',    'Q', moveq1);
ut.MAC_SK_Move('~thor_data400::key::accident_state_restrictions::report',    'Q', moveq2);

move_qa_keys := parallel(moveq1,moveq2);




do_all:= sequential(
					build_keys
					,move_build_keys
					,move_qa_keys
		      );
					//: success(send_succ_msg),failure(send_fail_msg);
return do_all;
												   
end;