import ut, RoxieKeyBuild;

EXPORT Proc_BUild_keys	(
						string pVersion =  Births.Version_Development
						) := 
MODULE

filedate := pVersion;

pre0 := sequential(
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount('~thor_data400::base::births_building') > 0,
			output('Nothing added to births_building'),
			fileservices.addsuperfile('~thor_data400::base::births_building','~thor_data400::base::births',,true)),
		fileservices.finishsuperfiletransaction()
		);

//MAC_SK_BuildProcess_Local(theindexprep, keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false') := macro
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Births.Key_Births_DID
                                       ,'~thor_data400::key::births::' + filedate + '::did'
									   ,'~thor_data400::key::births::did',bk0,2);

// Move all the keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::births::' + filedate + '::did'
                                  ,'~thor_data400::key::births::did'
								  ,move1);
move_build_keys := parallel(move1);

// Move all the keys to QA
ut.MAC_SK_Move('~thor_data400::key::births::did','Q', moveq1);
move_qa_keys := parallel(moveq1);

pre1 := sequential(
					fileservices.startsuperfiletransaction(),
					fileservices.clearsuperfile('~thor_data400::base::births_built'),
					fileservices.addsuperfile('~thor_data400::base::births_built','~thor_data400::base::births_building',,true),
					fileservices.clearsuperfile('~thor_data400::base::births_building'),
					fileservices.finishsuperfiletransaction()
				   );

email_send_list := 'jbello@seisint.com';
// email_send_list := 'dqi@seisint.com,jbello@seisint.com,RoxieBuilds@seisint.com';


RoxieKeyBuild.Mac_Daily_Email_Local('BIRTHS'
                                   ,'SUCC'
								   ,filedate
								   ,send_succ_msg
								   ,email_send_list);
RoxieKeyBuild.Mac_Daily_Email_Local('BIRTHS'
                                   ,'FAIL'
								   ,filedate
								   ,send_fail_msg
								   ,email_send_list);

export All := sequential(pre0
									 ,parallel(bk0)
									 ,move_build_keys
									 ,move_qa_keys
									 ,pre1) : success(send_succ_msg)
											 ,failure(send_fail_msg);
END;