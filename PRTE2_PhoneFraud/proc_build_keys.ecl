IMPORT ut,RoxieKeyBuild,_control, PRTE2_PhoneFraud,PRTE2_Common, PRTE;

EXPORT proc_build_keys(string file_date, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 	:= is_running_in_prod AND NOT skipDOPS;
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys.Key_OTP,
		Constants.KeyName_PhoneFraud + Constants.KeyName_PhoneFraud_otp + '_@version@',
		Constants.KeyName_PhoneFraud  + file_date + '::' + Constants.KeyName_PhoneFraud_otp, 
		build_key_otp);
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys.Key_spoofing,
		Constants.KeyName_PhoneFraud + Constants.KeyName_PhoneFraud_spoofing + '_@version@',
		Constants.KeyName_PhoneFraud  + file_date + '::' + Constants.KeyName_PhoneFraud_spoofing, 
		build_key_spoofing);
	

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_PhoneFraud + Constants.KeyName_PhoneFraud_otp + '_@version@', 
		Constants.KeyName_PhoneFraud  + file_date + '::' + Constants.KeyName_PhoneFraud_otp, 
		move_built_key_otp);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_PhoneFraud + Constants.KeyName_PhoneFraud_spoofing + '_@version@',
		Constants.KeyName_PhoneFraud  + file_date + '::' + Constants.KeyName_PhoneFraud_spoofing, 
		move_built_key_spoofing);


	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_PhoneFraud + Constants.KeyName_PhoneFraud_otp + '_@version@', 
		'Q', 
		move_qa_key_otp);

	RoxieKeyBuild.MAC_SK_Move_v2( Constants.KeyName_PhoneFraud + Constants.KeyName_PhoneFraud_spoofing + '_@version@',
		'Q', 
		move_qa_key_spoofing);

		
	//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, file_date, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);

	RETURN 		sequential(			
				build_key_otp, 
				build_key_spoofing,
				move_built_key_otp, 
				move_built_key_spoofing, 
				move_qa_key_otp, 
				move_qa_key_spoofing, 
				PerformUpdateOrNot);

END;
