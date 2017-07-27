import ut,roxiekeybuild, doxie_files;


export proc_build_key(string filedate) := function
	SuperKeyName 					:= cluster.cluster_out+'key::hunting_fishing::';
	SuperKeyName_fcra			:= cluster.cluster_out+'key::hunting_fishing::fcra::';
	SuperKeyName_CCW 			:= cluster.cluster_out+'key::ccw::';
	SuperKeyName_CCW_fcra := cluster.cluster_out+'key::ccw::fcra::';
	BaseKeyName  					:= SuperKeyName+filedate;
	BaseKeyName_fcra			:= SuperKeyName_fcra+filedate;	
	BaseKeyName_CCW 			:= SuperKeyName_CCW+filedate;
	BaseKeyName_CCW_fcra	:= SuperKeyName_CCW_fcra+filedate;
	
	pre := sequential(
			fileservices.startsuperfiletransaction(),
			if (fileservices.getsuperfilesubcount('~thor_Data400::base::emerges_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				fileservices.addsuperfile('~thor_Data400::base::emerges_BUILDING','~thor_data400::base::emerges_hunt_vote_ccw',0,true)),
			fileservices.finishsuperfiletransaction()
			);

	a := emerges.make_hvc_output(filedate);

	pre2 := sequential(
			fileservices.startsuperfiletransaction(),
			if (fileservices.getsuperfilesubcount('~thor_Data400::base::emerges_hunt_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				fileservices.addsuperfile('~thor_Data400::base::emerges_hunt_BUILDING','~thor_data400::base::emerges_hunt',0,true)),
			if (fileservices.getsuperfilesubcount('~thor_Data400::base::emerges_ccw_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				fileservices.addsuperfile('~thor_Data400::base::emerges_ccw_BUILDING','~thor_data400::base::emerges_ccw',0,true)),
			fileservices.finishsuperfiletransaction()
			);
			
	Roxiekeybuild.MAC_SK_BuildProcess_Local(doxie_files.key_hunters_did(),'~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did','~thor_Data400::key::hunters_doxie_did',key1);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.Key_huntfish_did(),SuperKeyName+'did',BaseKeyName+'::did',key2);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.Key_huntfish_rid(),SuperKeyName+'rid',BaseKeyName+'::rid',key3);
	// Roxiekeybuild.MAC_SK_BuildProcess_Local(emerges.key_prep_hunters_did,'~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did','~thor_Data400::key::hunters_doxie_did',key1);
	// RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_huntfish_did,SuperKeyName+'did',BaseKeyName+'::did',key2);
	// RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_huntfish_rid,SuperKeyName+'rid',BaseKeyName+'::rid',key3);
	roxiekeybuild.MAC_SK_BuildProcess_Local(doxie_files.key_ccw_did(),'~thor_Data400::key::emerges::'+filedate+'::ccw_doxie_did','~thor_Data400::key::ccw_doxie_did',key4);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.key_ccw_did(),SuperKeyName_CCW+'did',BaseKeyName_CCW+'::did',key5);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.key_ccw_rid(),SuperKeyName_CCW+'rid',BaseKeyName_CCW+'::rid',key6);
	
	Roxiekeybuild.MAC_SK_Move_To_Built('~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did','~thor_Data400::key::hunters_doxie_did',mv1);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did',BaseKeyName+'::did',mv2,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::rid',BaseKeyName+'::rid',mv3,2);
	roxiekeybuild.MAC_SK_Move_To_Built('~thor_Data400::key::emerges::'+filedate+'::ccw_doxie_did','~thor_Data400::key::ccw_doxie_did',mv4);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_CCW+'@version@::did',BaseKeyName_CCW+'::did',mv5,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_CCW+'@version@::rid',BaseKeyName_CCW+'::rid',mv6,2);
	
	// Build FCRA keys
	Roxiekeybuild.MAC_SK_BuildProcess_Local(doxie_files.key_hunters_did(true),'~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did_fcra','~thor_Data400::key::hunters_doxie_did_fcra',key1_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.Key_huntfish_did(true),SuperKeyName_fcra+'did',BaseKeyName_fcra+'::did',key2_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.Key_huntfish_rid(true),SuperKeyName_fcra+'rid',BaseKeyName_fcra+'::rid',key3_fcra);
	roxiekeybuild.MAC_SK_BuildProcess_Local(doxie_files.key_ccw_did(true),'~thor_Data400::key::emerges::'+filedate+'::ccw_doxie_did_fcra','~thor_Data400::key::ccw_doxie_did_fcra',key4_fcra);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.key_ccw_did(true),SuperKeyName_CCW_fcra+'did',BaseKeyName_CCW_fcra+'::did',key5_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.key_ccw_rid(true),SuperKeyName_CCW_fcra+'rid',BaseKeyName_CCW_fcra+'::rid',key6_fcra);
	
	// Move FCRA keys
	Roxiekeybuild.MAC_SK_Move_To_Built('~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did_fcra','~thor_Data400::key::hunters_doxie_did_fcra',mv1_fcra);	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_fcra+'@version@::did',BaseKeyName_fcra+'::did',mv2_fcra,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_fcra+'@version@::rid',BaseKeyName_fcra+'::rid',mv3_fcra,2);	
	Roxiekeybuild.MAC_SK_Move_To_Built('~thor_Data400::key::emerges::'+filedate+'::ccw_doxie_did_fcra','~thor_Data400::key::ccw_doxie_did_fcra',mv4_fcra);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_CCW_fcra+'@version@::did',BaseKeyName_CCW_fcra+'::did',mv5_fcra,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_CCW_fcra+'@version@::rid',BaseKeyName_CCW_fcra+'::rid',mv6_fcra,2);
	

	RoxieKeyBuild.Mac_Daily_Email_Local('EMERGES','SUCC',filedate,send_succ_msg,emerges.Spray_Notification_Email_Address);
	RoxieKeyBuild.Mac_Daily_Email_Local('EMERGES','FAIL',filedate,send_fail_msg,'kgummadi@seisint.com;fhumayun@seisint.com');

	move_qa := eMerges.proc_accept_sk_to_QA;
	
	build_huntfish_autokeys 			:= emerges.Proc_HuntFish_AutokeyBuild(filedate);
	build_huntfish_autokeys_fcra	:= emerges.Proc_HuntFish_AutokeyBuild_fcra(filedate);	
  build_CCW_autokeys						:= emerges.Proc_CCW_AutokeyBuild(filedate);
	build_CCW_autokeys_fcra				:= emerges.Proc_CCW_AutokeyBuild_fcra(filedate);
	
	update_dops := roxiekeybuild.updateversion('EmergesKeys',filedate,'kgummadi@seisint.com;fhumayun@seisint.com');
	
	build_roxie_keys := 
	  if (fileservices.getsuperfilesubname('~thor_data400::base::emerges_hunt_vote_ccw',1) = fileservices.getsuperfilesubname('~thor_data400::base::emerges_BUILT',1),
				output('BASE = BUILT, Nothing done.'),
				sequential(pre,a,pre2,
									 parallel(key1,key2,key3,key4,key5,key6),
									 parallel(mv1,mv2,mv3,mv4,mv5,mv6),				
									 parallel(key1_fcra,key2_fcra,key3_fcra,key4_fcra,key5_fcra,key6_fcra),
									 parallel(key4_fcra,key5_fcra,key6_fcra),
									 parallel(mv1_fcra,mv2_fcra,mv3_fcra,mv4_fcra,mv5_fcra,mv6_fcra),
									 parallel(mv4_fcra,mv5_fcra,mv6_fcra),
									 move_qa,
									 build_huntfish_autokeys,
									 build_huntfish_autokeys_fcra,
									 build_ccw_autokeys,
									 build_ccw_autokeys_fcra,
									 update_dops
									 )) : success(send_succ_msg), failure(send_fail_msg);

	build_moxie_keys := emerges.proc_build_all_moxie_keys : success(output('moxie keys build completed')), failure(output('moxie key build failed'));

	post_build := sequential(
													fileservices.startsuperfiletransaction(),
													fileservices.clearsuperfile('~thor_data400::base::emerges_hunt_BUILT'),
													fileservices.addsuperfile('~thor_data400::base::emerges_hunt_BUILT','~thor_data400::base::emerges_hunt_BUILDING',0,true),
													fileservices.clearsuperfile('~thor_Data400::base::emerges_hunt_BUILDING'),
													fileservices.clearsuperfile('~thor_data400::base::emerges_ccw_BUILT'),
													fileservices.addsuperfile('~thor_data400::base::emerges_ccw_BUILT','~thor_data400::base::emerges_ccw_BUILDING',0,true),
													fileservices.clearsuperfile('~thor_Data400::base::emerges_ccw_BUILDING'),
													fileservices.clearsuperfile('~thor_data400::base::emerges_BUILT'),
													fileservices.addsuperfile('~thor_data400::base::emerges_BUILT','~thor_data400::base::emerges_BUILDING',0,true),
													fileservices.clearsuperfile('~thor_Data400::base::emerges_BUILDING'),
													fileservices.finishsuperfiletransaction()
													);	
													
	return sequential(build_roxie_keys,
										build_moxie_keys,
										post_build);
	
end;