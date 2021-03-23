IMPORT ut,RoxieKeyBuild,_control, PRTE2_PhonesInfo ,PRTE2_Common, PRTE, prte2, dops;

EXPORT proc_build_keys(string file_date, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 	:= is_running_in_prod AND NOT skipDOPS;
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys.key_carrier_reference,
		Constants.KeyName_phones + Constants.KeyName_carrier_reference + '_@version@',
		Constants.KeyName_phones  + file_date + '::' + Constants.KeyName_carrier_reference, 
		build_key_carrier_reference);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_phones + Constants.KeyName_carrier_reference + '_@version@', 
		Constants.KeyName_phones  + file_date + '::' + Constants.KeyName_carrier_reference, 
		move_built_key_carrier_reference);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_phones + Constants.KeyName_carrier_reference + '_@version@', 
		'Q', 
		move_qa_key_carrier_reference);


RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys.key_Lerg6Main,
		Constants.KeyName_phones + Constants.KeyName_lerg6 + '_@version@',
		Constants.KeyName_phones  + file_date + '::' + Constants.KeyName_lerg6, 
		build_key_lerg6);


RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_phones + Constants.KeyName_lerg6 + '_@version@', 
		Constants.KeyName_phones  + file_date + '::' + Constants.KeyName_lerg6, 
		move_built_key_lerg6);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_phones + Constants.KeyName_lerg6 + '_@version@', 
		'Q', 
		move_qa_key_lerg6);

//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, file_date, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
		
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);
//---------------------------------------------------------------------------------------
  

	key_validation :=  output(dops.ValidatePRCTFileLayout(file_date, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));
	
	
	RETURN 		sequential(parallel(build_key_carrier_reference,build_key_lerg6), 
											 parallel(move_built_key_carrier_reference, move_built_key_lerg6),
											 parallel(move_qa_key_carrier_reference,move_qa_key_lerg6),   
											 PerformUpdateOrNot,
											 key_validation
											 );

END;
