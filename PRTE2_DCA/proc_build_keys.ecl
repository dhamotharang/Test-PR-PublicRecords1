IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_DCA, PRTE2_Common, dops, prte2, orbit3, std;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

//Built Roxie Keys
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_entnum, Constants.dca_keyname + '@version@::entnum', Constants.dca_keyname + filedate + '::entnum', build_key_entnum);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_entnum_nonfilt, Constants.dca_keyname + '@version@::entnum_nonfilt',Constants.dca_keyname + filedate + '::entnum_nonfilt', build_key_entnum_nonfilt);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hierarchy_parent_to_child_entnum, 
																							Constants.dca_keyname + '@version@::hierarchy_parent_to_child_entnum',
																							Constants.dca_keyname + filedate + '::hierarchy_parent_to_child_entnum', 
																							build_key_hierarchy_parent_to_child_entnum);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_linkids.key,	Constants.dca_keyname + '@version@::linkids',	Constants.dca_keyname + filedate + '::linkids', build_key_linkids);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_bdid, Constants.dca_keyname + '@version@::bdid',	Constants.dca_keyname + filedate + '::bdid', build_key_bdid);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hierarchy_bdid, Constants.dca_keyname + '@version@::hierarchy_bdid', Constants.dca_keyname + filedate + '::hierarchy_bdid', build_key_hierarchy_bdid);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hierarchy_parent_to_child_root_sub,
																							Constants.dca_keyname + '@version@::hierarchy_parent_to_child_root_sub',
																							Constants.dca_keyname + filedate + '::hierarchy_parent_to_child_root_sub', 
																							build_key_hierarchy_parent_to_child_root_sub);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hierarchy_root_sub, 
																							Constants.dca_keyname + '@version@::hierarchy_root_sub',
																							Constants.dca_keyname + filedate + '::hierarchy_root_sub', 
																							build_key_hierarchy_root_sub);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_root_sub,Constants.dca_keyname + '@version@::root_sub',Constants.dca_keyname + filedate + '::root_sub', build_key_root_sub);

//CCPA Phase 2- New Key	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_contacts_bdid,Constants.dca_keyname + '@version@::contacts_bdid',Constants.dca_keyname + filedate + '::contacts_bdid', build_key_contacts_bdid);


//Move Keys to BUILt
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::entnum', Constants.dca_keyname + filedate + '::entnum',	move_built_key_entnum);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::entnum_nonfilt', Constants.dca_keyname + filedate + '::entnum_nonfilt', move_built_key_entnum_nonfilt);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::hierarchy_parent_to_child_entnum', Constants.dca_keyname + filedate + '::hierarchy_parent_to_child_entnum',
																					move_built_key_hierarchy_parent_to_child_entnum);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::linkids', 	Constants.dca_keyname + filedate + '::linkids',	move_built_key_linkids);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::bdid', Constants.dca_keyname + filedate + '::bdid',	move_built_key_bdid);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::hierarchy_bdid@', 	Constants.dca_keyname + filedate + '::hierarchy_bdid', move_built_key_hierarchy_bdid);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::hierarchy_parent_to_child_root_sub', 
																				 Constants.dca_keyname + filedate + '::hierarchy_parent_to_child_root_sub',
																				 move_built_key_hierarchy_parent_to_child_root_sub);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::hierarchy_root_sub', 
																				 Constants.dca_keyname + filedate + '::hierarchy_root_sub',
																				 move_built_key_hierarchy_root_sub);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::root_sub', 
																				 Constants.dca_keyname + filedate + '::root_sub',
																					move_built_key_root_sub);
//New Key
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.dca_keyname + '@version@::contacts_bdid', Constants.dca_keyname + filedate + '::contacts_bdid',move_built_key_contacts_bdid);


//Move Keys to QA
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::entnum', 														'Q', move_qa_key_entnum);
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::entnum_nonfilt', 										'Q', 	move_qa_key_entnum_nonfilt);
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::hierarchy_parent_to_child_entnum', 	'Q', 	move_qa_key_hierarchy_parent_to_child_entnum);
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::linkids', 														'Q', move_qa_key_linkids);
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::bdid', 															'Q', 	move_qa_key_bdid);
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::hierarchy_bdid', 										'Q', move_qa_key_hierarchy_bdid);
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::hierarchy_parent_to_child_root_sub', 'Q', move_qa_key_hierarchy_parent_to_child_root_sub);
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::hierarchy_root_sub', 								'Q', move_qa_key_hierarchy_root_sub);
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::root_sub', 													'Q', move_qa_key_root_sub);
//New Key	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.dca_keyname + '@version@::contacts_bdid',											'Q', move_qa_key_contacts_bdid);

//Autokeys
		AutoKeyB2.MAC_Build(files.file_autokey,blank,blank,blank,
												blank,
												zero,
												zero,
												blank_prim_name, blank_prim_range, blank_st, blank_city, blank_zip5, blank_sec_range, 
												zero,
												zero,zero,zero,
												zero,zero,zero,
												zero,zero,zero,
												zero,
												zero,
												company_name,
												zero,
												company_phone,
												Bus_addr.prim_name,Bus_addr.prim_range,Bus_addr.st,Bus_addr.p_city_name,Bus_addr.zip5,Bus_addr.sec_range,
												bdid,
												constants.ak_keyname,
												constants.ak_logical(filedate),
												outaction,,
												constants.ak_skip_set,true,constants.ak_typestr,
												true,,,bdid,false);

	AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.ak_skip_set) 

	retval := 	sequential(outaction,mymove); 

	// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION --------------------- 
		is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
		notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
		updatedops					:= PRTE.UpdateVersion(constants.dataset_name, 
																							filedate, 
																							notifyEmail,
																							l_inloc:='B',							//	B = Boca, A = Alpharetta
																							l_inenvment:='N',					//	N = Non-FCRA, F = FCRA
																							l_includeboolean :='N'		 //	N = Do not also include boolean, Y = Include boolean, too
																							);
		
		PerformUpdateOrNot	:= IF(doDOPS,updatedops,NoUpdate);
  //-------------------------------------------------------------------

// Key Validation
	key_validation 			:= output(dops.ValidatePRCTFileLayout(filedate, 
																														prte2.Constants.ipaddr_prod, 
																														prte2.Constants.ipaddr_roxie_nonfcra,
																														constants.dataset_name, 
																														'N', ), named(constants.dataset_name+'Validation'));
	
	build_keys	:=	sequential(			
												parallel(build_key_entnum,build_key_entnum_nonfilt, build_key_hierarchy_parent_to_child_entnum, 
																	build_key_linkids, build_key_bdid, build_key_hierarchy_bdid, build_key_hierarchy_parent_to_child_root_sub, 
																	build_key_hierarchy_root_sub, build_key_root_sub,
																	build_key_contacts_bdid), 
												parallel(move_built_key_entnum, move_built_key_entnum_nonfilt, move_built_key_hierarchy_parent_to_child_entnum, 
																 move_built_key_linkids, move_built_key_bdid, move_built_key_hierarchy_bdid, move_built_key_hierarchy_parent_to_child_root_sub, 
																 move_built_key_hierarchy_root_sub, move_built_key_root_sub,
																 move_built_key_contacts_bdid), 						
												parallel(move_qa_key_entnum, move_qa_key_entnum_nonfilt, move_qa_key_hierarchy_parent_to_child_entnum, 
																 move_qa_key_linkids, move_qa_key_bdid, move_qa_key_hierarchy_bdid, move_qa_key_hierarchy_parent_to_child_root_sub, 
																 move_qa_key_hierarchy_root_sub, move_qa_key_root_sub,
																 move_qa_key_contacts_bdid) 
												,retval
												,key_validation
												,PerformUpdateOrNot
											);



return build_keys;

END;
