IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control,PRTE2_Common;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_linkids.key,
    constants.KeyName_crashcarrier + '@version@::linkids',
		constants.KeyName_crashcarrier + filedate + '::linkids', build_key_crashcarrier_linkids);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_crashcarrier +'@version@::linkids', 
	constants.KeyName_crashcarrier + filedate + '::linkids',
	move_built_key_crashcarrier_linkids);

RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_crashcarrier + '@version@::linkids', 
	'Q', 
	move_qa_key_crashcarrier_linkids);
	
 //---------- making DOPS optional and only in PROD build -------------------------------
 is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
 NoUpdate           := OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
 updatedops         := PRTE.UpdateVersion('CrashCarrierKeys', filedate, _control.MyInfo.EmailAddressNormal,'B','N','N');
 PerformUpdateOrNot := IF(is_running_in_prod,updatedops,NoUpdate);


RETURN 		sequential(build_key_crashcarrier_linkids, 
			move_built_key_crashcarrier_linkids, 
			move_qa_key_crashcarrier_linkids,
			PerformUpdateOrNot); 
																							

END;
