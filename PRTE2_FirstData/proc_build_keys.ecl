import dx_FirstData,Orbit3, RoxieKeyBuild, prte2_firstdata, dops, prte2_common, _control, prte, prte2;

EXPORT proc_build_keys(STRING	pversion, boolean skipDOPS=FALSE, string emailTo=''):=function
	
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(prte2_firstdata.keys.drvr_license, prte2_firstdata.constants.keyname + 'driverslicense', prte2_firstdata.constants.key_prefix +pVersion+ '::driverslicense', build_key_license);
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(prte2_firstdata.keys.did_fcra, prte2_firstdata.constants.keyname_fcra + 'did', prte2_firstdata.constants.key_prefix + 'fcra::' +pVersion+ '::did', build_key_did_fcra);
	

	build_fd_keys := parallel(build_key_license, build_key_did_fcra);

	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_firstdata.constants.keyname + 'driverslicense', prte2_firstdata.constants.key_prefix +pversion+ '::driverslicense', mv_key_driverslicense);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_firstdata.constants.keyname_fcra + 'did', prte2_firstdata.constants.key_prefix + 'fcra::' +pversion+ '::did', mv_key_did_fcra);

	move_built_keys := parallel(mv_key_driverslicense, mv_key_did_fcra);
	

	RoxieKeyBuild.Mac_SK_Move_v3(prte2_firstdata.constants.keyname + 'driverslicense',	'Q', mv_key_driverslicense_qa,pversion);
	RoxieKeyBuild.MAC_SK_Move_v3(prte2_firstdata.constants.keyname_fcra + 'did', 			'Q', mv_key_did_fcra_qa, pversion);

  qa_keys := parallel(mv_key_driverslicense_qa, mv_key_did_fcra_qa);
	
//---------- making DOPS optional and only in PROD build -------------------------------	
		dataset_name			:= 'FirstDataKeys';
		dataset_name_fcra	:= 'FCRA_FirstDataKeys';
		is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 									:= is_running_in_prod AND NOT skipDOPS;		
		notifyEmail 						:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 								:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		PerformUpdate 					:= PRTE.UpdateVersion(dataset_name, pversion, notifyEmail, l_inloc:='B', l_inenvment:='N', l_includeboolean :='N');
		PerformUpdate_fcra			:= PRTE.UpdateVersion(dataset_name_fcra, pversion, notifyEmail, l_inloc:='B', l_inenvment:='f', l_includeboolean :='N');
		PerformUpdateOrNot 			:= IF(doDOPS, parallel(PerformUpdate,PerformUpdate_fcra), NoUpdate);
		//--------------------------------------------------------------------------------------
		key_validation 			:=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dataset_name, 'N'), named(dataset_name+'Validation'));
		key_validation_fcra :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_fcra,dataset_name_fcra, 'F'), named(dataset_name_fcra+'Validation'));	
	
	// create_build := Orbit3.proc_Orbit3_CreateBuild ('First Data',pversion,'F');
	
	build_keys := sequential(
	build_fd_keys 
	                         ,move_built_keys
													 ,qa_keys
													 ,parallel(key_validation, key_validation_fcra)
													 // ,PerformUpdateOrNot
																
																);

	return build_keys;
	
end;	
