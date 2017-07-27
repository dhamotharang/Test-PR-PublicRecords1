//this program is to build flcrash keys
import ut, RoxieKeyBuild;

// Don't forget to update the Version Development attribute with the new build date
#workunit ('name', 'Build FLCrash Key Files');


// Don't forget to update the Version Development attribute with the new build date
filedate := FLAccidents.Version_Development;

pre0 := sequential(
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash0_building') > 0,
			output('Nothing added to flcrash0_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash0_building','~thor_data400::base::flcrash0',,true)),
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash1_building') > 0,
			output('Nothing added to flcrash1_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash1_building','~thor_data400::base::flcrash1',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash2v_building') > 0,
			output('Nothing added to flcrash2v_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash2v_building','~thor_data400::base::flcrash2v',,true)),	
     	if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash3v_building') > 0,
			output('Nothing added to flcrash3v_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash3v_building','~thor_data400::base::flcrash3v',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash4_building') > 0,
			output('Nothing added to flcrash4_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash4_building','~thor_data400::base::flcrash4',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash5_building') > 0,
			output('Nothing added to flcrash5_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash5_building','~thor_data400::base::flcrash5',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash6_building') > 0,
			output('Nothing added to flcrash6_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash6_building','~thor_data400::base::flcrash6',,true)),	
        if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash7_building') > 0,
			output('Nothing added to flcrash7_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash7_building','~thor_data400::base::flcrash7',,true)),	  
        if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash8_building') > 0,
			output('Nothing added to flcrash8_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash8_building','~thor_data400::base::flcrash8',,true)),
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash9_building') > 0,
			output('Nothing added to flcrash9_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash9_building','~thor_data400::base::flcrash9',,true)),	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash_did_building') > 0,
			output('Nothing added to flcrash_did_building'),
			fileservices.addsuperfile('~thor_data400::base::flcrash_did_building','~thor_data400::base::flcrash_did',,true)),	  	
		if (fileservices.getsuperfilesubcount('~thor_data400::base::flcrash_ss_building') > 0,
			output('Nothing added to flcrash_ss_building'),
		  fileservices.addsuperfile('~thor_data400::base::flcrash_ss_building','~thor_data400::base::flcrash_ss',,true)),	  	
		fileservices.finishsuperfiletransaction()
		);

//MAC_SK_BuildProcess_Local(theindexprep, keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false') := macro
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash0
                     ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash0'
    									   ,'~thor_data400::key::flcrash0',bk0,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash1
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash1'
					  			       ,'~thor_data400::key::flcrash1',bk1,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash2v
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash2v'
					  			       ,'~thor_data400::key::flcrash2v',bk2,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash3v
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash3v'
					  			       ,'~thor_data400::key::flcrash3v',bk3,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash4
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash4'
	 				  			       ,'~thor_data400::key::flcrash4',bk4,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash5
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash5'
					  			       ,'~thor_data400::key::flcrash5',bk5,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash6
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash6'
					  			       ,'~thor_data400::key::flcrash6',bk6,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash7
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash7'
					  			       ,'~thor_data400::key::flcrash7',bk7,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash8
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash8'
					  			       ,'~thor_data400::key::flcrash8',bk8,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash9
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash9'
					  			       ,'~thor_data400::key::flcrash9',bk9,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_Flcrash_Did
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::did'
					  			       ,'~thor_data400::key::flcrash_did',bk_did,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_Flcrash_AccNbr
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::accnbr'
					                   ,'~thor_data400::key::flcrash_accnbr',bk_accnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_Flcrash_Bdid
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::bdid'
					                   ,'~thor_data400::key::flcrash_bdid',bk_bdid,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash_DLNbr
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::dlnbr'
					  			       ,'~thor_data400::key::flcrash_dlnbr',bk_dlnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_FLCrash_TagNbr
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::tagnbr'
					      			   ,'~thor_data400::key::flcrash_tagnbr',bk_tagnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_Flcrash_VIN
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::vin'
					  			       ,'~thor_data400::key::flcrash_vin',bk_vin,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents.Key_Flcrash_LinkIds.Key
									   ,'~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::linkids'
					                   ,'~thor_data400::key::flcrash_linkids',bk_linkids,2);

// Move all the keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash0'
                                  ,'~thor_data400::key::flcrash0'
								  ,move1);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash1'
                                  ,'~thor_data400::key::flcrash1'
								  ,move2);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash2v'
                                  ,'~thor_data400::key::flcrash2v'
								  ,move3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash3v'
                                  ,'~thor_data400::key::flcrash3v'
								  ,move4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash4'
                                  ,'~thor_data400::key::flcrash4'
								  ,move5);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash5'
                                  ,'~thor_data400::key::flcrash5'
								  ,move6);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash6'
                                  ,'~thor_data400::key::flcrash6'
								  ,move7);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash7'
                                  ,'~thor_data400::key::flcrash7'
								  ,move8);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash8'
                                  ,'~thor_data400::key::flcrash8'
								  ,move9);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::flcrash9'
                                  ,'~thor_data400::key::flcrash9'
								  ,move10);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::did'
                                  ,'~thor_data400::key::flcrash_did'
								  ,move11);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::accnbr'
                                  ,'~thor_data400::key::flcrash_accnbr'
								  ,move12);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::bdid'
                                  ,'~thor_data400::key::flcrash_bdid'
								  ,move13);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::dlnbr'
                                  ,'~thor_data400::key::flcrash_dlnbr'
								  ,move14);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::tagnbr'
                                  ,'~thor_data400::key::flcrash_tagnbr'
								  ,move15);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::vin'
                                  ,'~thor_data400::key::flcrash_vin'
								  ,move16);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::flcrash::' + FLAccidents.Version_Development + '::linkids'
                                  ,'~thor_data400::key::flcrash_linkids'
								  ,move17);									
move_build_keys := parallel(move1,move2,move3,move4,move5,move6,move7,move8,move9,move10
							,move11,move12,move13,move14,move15,move16,move17);

// Move all the keys to QA
ut.MAC_SK_Move('~thor_data400::key::flcrash0',    'Q', moveq1);
ut.MAC_SK_Move('~thor_data400::key::flcrash1',    'Q', moveq2);
ut.MAC_SK_Move('~thor_data400::key::flcrash2v',   'Q', moveq3);
ut.MAC_SK_Move('~thor_data400::key::flcrash3v',   'Q', moveq4);
ut.MAC_SK_Move('~thor_data400::key::flcrash4',    'Q', moveq5);
ut.MAC_SK_Move('~thor_data400::key::flcrash5',    'Q', moveq6);
ut.MAC_SK_Move('~thor_data400::key::flcrash6',    'Q', moveq7);
ut.MAC_SK_Move('~thor_data400::key::flcrash7',    'Q', moveq8);
ut.MAC_SK_Move('~thor_data400::key::flcrash8',    'Q', moveq9);
ut.MAC_SK_Move('~thor_data400::key::flcrash9',    'Q', moveq10);
ut.MAC_SK_Move('~thor_data400::key::flcrash_did', 'Q', moveq11);
ut.MAC_SK_Move('~thor_data400::key::flcrash_accnbr','Q', moveq12);
ut.MAC_SK_Move('~thor_data400::key::flcrash_bdid',  'Q', moveq13);
ut.MAC_SK_Move('~thor_data400::key::flcrash_dlnbr', 'Q', moveq14);
ut.MAC_SK_Move('~thor_data400::key::flcrash_tagnbr','Q', moveq15);
ut.MAC_SK_Move('~thor_data400::key::flcrash_vin',   'Q', moveq16);
ut.MAC_SK_Move('~thor_data400::key::flcrash_linkids', 'Q', moveq17);


move_qa_keys := parallel(moveq1,moveq2,moveq3,moveq4,moveq5,moveq6,moveq7,moveq8,moveq9,moveq10
							,moveq11,moveq12,moveq13,moveq14,moveq15,moveq16,moveq17);

pre1 := sequential(// Begin the file transaction process
					fileservices.startsuperfiletransaction(),
					// File 0
					fileservices.clearsuperfile('~thor_data400::base::flcrash0_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash0_built','~thor_data400::base::flcrash0_building',,true),
					fileservices.clearsuperfile('~thor_data400::base::flcrash0_building'),
					// File 1		
					fileservices.clearsuperfile('~thor_data400::base::flcrash1_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash1_built','~thor_data400::base::flcrash1_building',,true),
					fileservices.clearsuperfile('~thor_data400::base::flcrash1_building'),
					// File 2v
					fileservices.clearsuperfile('~thor_data400::base::flcrash2v_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash2v_built','~thor_data400::base::flcrash2v_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash2v_building'),
					// File 3v
					fileservices.clearsuperfile('~thor_data400::base::flcrash3v_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash3v_built','~thor_data400::base::flcrash3v_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash3v_building'),
					// File 4
					fileservices.clearsuperfile('~thor_data400::base::flcrash4_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash4_built','~thor_data400::base::flcrash4_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash4_building'),
					// File 5
					fileservices.clearsuperfile('~thor_data400::base::flcrash5_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash5_built','~thor_data400::base::flcrash5_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash5_building'),
					// File 6
					fileservices.clearsuperfile('~thor_data400::base::flcrash6_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash6_built','~thor_data400::base::flcrash6_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash6_building'),
					// File 7
					fileservices.clearsuperfile('~thor_data400::base::flcrash7_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash7_built','~thor_data400::base::flcrash7_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash7_building'),
					// File 8
					fileservices.clearsuperfile('~thor_data400::base::flcrash8_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash8_built','~thor_data400::base::flcrash8_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash8_building'),
					// File 9
					fileservices.clearsuperfile('~thor_data400::base::flcrash9_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash9_built','~thor_data400::base::flcrash9_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash9_building'),
					// File DID
					fileservices.clearsuperfile('~thor_data400::base::flcrash_did_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash_did_built','~thor_data400::base::flcrash_did_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash_did_building'),
					// File SS
					fileservices.clearsuperfile('~thor_data400::base::flcrash_ss_built'),
					fileservices.addsuperfile('~thor_data400::base::flcrash_ss_built','~thor_data400::base::flcrash_ss_building',,true),	
					fileservices.clearsuperfile('~thor_data400::base::flcrash_ss_building'),
					// End the file transaction process
					fileservices.finishsuperfiletransaction()
				   );
					 
email_send_list := 'jbello@seisint.com';
// email_send_list := 'dqi@seisint.com,jbello@seisint.com,RoxieBuilds@seisint.com';


RoxieKeyBuild.Mac_Daily_Email_Local('FLCRASH'
                                   ,'SUCC'
								   ,filedate
								   ,send_succ_msg
								   ,email_send_list);
RoxieKeyBuild.Mac_Daily_Email_Local('FLCRASH'
                                   ,'FAIL'
								   ,filedate
								   ,send_fail_msg
								   ,email_send_list);

export flcrash_buildkeys := sequential(pre0,
										   parallel(bk0,bk1,bk2,bk3,bk4,bk5,bk6,bk7,bk8,bk9
											 ,bk_did,bk_accnbr,bk_bdid,bk_dlnbr,bk_tagnbr,bk_vin,bk_linkids)
										   ,move_build_keys
										   ,move_qa_keys
										   ,pre1) : success(send_succ_msg)
										           ,failure(send_fail_msg); 