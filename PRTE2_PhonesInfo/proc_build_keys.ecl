IMPORT ut,RoxieKeyBuild,_control, PRTE2_PhonesInfo ,PRTE2_Common, PRTE;

EXPORT proc_build_keys(string file_date, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 	:= is_running_in_prod AND NOT skipDOPS;
	
	//phones_ported_metadata
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys.key_phones_ported_metadata,
		Constants.KeyName_phones + Constants.KeyName_phones_ported_metadata + '_@version@',
		Constants.KeyName_phones  + file_date + '::' + Constants.KeyName_phones_ported_metadata, 
		build_key_phones_ported_metadata);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_phones + Constants.KeyName_phones_ported_metadata + '_@version@', 
		Constants.KeyName_phones  + file_date + '::' + Constants.KeyName_phones_ported_metadata, 
		move_built_key_phones_ported_metadata);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_phones + Constants.KeyName_phones_ported_metadata + '_@version@', 
		'Q', 
		move_qa_key_phones_ported_metadata);

	//carrier_reference
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

//Lerg6Main
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
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, file_date, notifyEmail,'B','N','N');
		
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);

	RETURN 		sequential(			
				build_key_phones_ported_metadata, 
				move_built_key_phones_ported_metadata, 
				move_qa_key_phones_ported_metadata, 
				
				build_key_carrier_reference, 
				move_built_key_carrier_reference, 
				move_qa_key_carrier_reference, 	
				
				build_key_lerg6, 
				move_built_key_lerg6, 
				move_qa_key_lerg6, 	
			 	PerformUpdateOrNot);

END;
