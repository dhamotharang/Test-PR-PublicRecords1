import RoxieKeyBuild,PRTE, _control, STD,prte2,tools, PRTE2_Common, strata,dops;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function

is_running_in_prod 		:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 								:= is_running_in_prod AND NOT skipDOPS;

 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_did,
   Constants.key_prefix + '@version@::did',
	 Constants.key_prefix + filedate + '::did',build_key_did);
	 
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_did_FCRA,
   Constants.key_FCRA_prefix + '@version@::did',
	 Constants.key_FCRA_prefix + filedate + '::did',build_key_FCRA_did); 
	 
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Key_Email_Address,
   Constants.key_prefix + '@version@::email_addresses',
	 Constants.key_prefix + filedate + '::email_addresses',build_key_email_address);
	 
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Key_email_payload,
   Constants.key_prefix + '@version@::payload',
	 Constants.key_prefix + filedate + '::payload',build_key_payload);
	 
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Key_email_linkids,
   Constants.key_prefix + '@version@::linkids',
	 Constants.key_prefix + filedate + '::linkids',build_key_linkids);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Key_email_payload_FCRA,
   Constants.key_FCRA_prefix + '@version@::payload',
	 Constants.key_FCRA_prefix + filedate + '::payload',build_key_payload_FCRA);
	 
 
	 	 	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.key_prefix + '@version@::did', 
	 Constants.key_prefix + filedate + '::did',move_built_key_did);
	 
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.key_FCRA_prefix + '@version@::did', 
	 Constants.key_FCRA_prefix + filedate + '::did',move_built_key_FCRA_did);
	 
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.key_prefix + '@version@::email_addresses', 
	 Constants.key_prefix + filedate + '::email_addresses',move_built_key_email_address);
	 
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.key_prefix + '@version@::payload', 
	 Constants.key_prefix + filedate + '::payload',move_built_key_payload);
	 
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.key_prefix + '@version@::linkids', 
	 Constants.key_prefix + filedate + '::linkids',move_built_key_linkids);
	 
 
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.key_FCRA_prefix + '@version@::payload', 
	 Constants.key_FCRA_prefix + filedate + '::payload',move_built_key_payload_FCRA);
	 
	 			
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.key_prefix + '@version@::did', 
	'Q', 
	move_qa_key_did);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.key_FCRA_prefix + '@version@::did', 
	'Q', 
	move_qa_key_FCRA_did);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.key_prefix + '@version@::email_addresses', 
	'Q', 
	move_qa_key_email_address);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.key_prefix + '@version@::payload', 
	'Q', 
	move_qa_key_payload);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.key_prefix + '@version@::linkids', 
	'Q', 
	move_qa_key_linkids);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.key_FCRA_prefix + '@version@::payload', 
	'Q', 
	move_qa_key_payload_FCRA);
	
	build_autokeys 	:= Keys.autokeys(filedate);
	
	//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion('EmailDataV2Keys',filedate,notifyEmail,'B','N','N');
    //FCRA keys not yet active		
		//updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_EmailDataKeys',filedate,notifyEmail,'B','F','N');
		PerformUpdateOrNot 	:= IF(doDOPS,sequential(updatedops),NoUpdate);
//--------------------------------------------------------------------------------------

	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));
	
	buildKey	:=	sequential(
	                        Parallel(build_key_did,build_key_FCRA_did,build_key_email_address,build_key_payload, build_key_linkids,build_key_payload_FCRA),
												  Parallel(move_built_key_did,move_built_key_FCRA_did,move_built_key_email_address,move_built_key_payload,move_built_key_linkids,move_built_key_payload_FCRA),
												  Parallel(move_qa_key_did,move_qa_key_FCRA_did,move_qa_key_email_address,move_qa_key_payload,move_qa_key_linkids,move_qa_key_payload_FCRA),
							          	build_autokeys,
								          Remove_auto_payload,
								          PerformUpdateOrNot,
													key_validation);	

return	buildKey;
end;