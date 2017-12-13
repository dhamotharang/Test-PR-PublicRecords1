IMPORT RoxieKeyBuild, PRTE2_Common, PRTE, _control;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Key_Experian_LinkIDs.Key,
  constants.KeyName_experian_crdb + '@version@::linkids',
  constants.KeyName_experian_crdb + filedate + '::linkids', build_key_experian_crdb_linkids);
 	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_experian_crdb + '@version@::linkids', 
	constants.KeyName_experian_crdb + filedate + '::linkids',
	move_built_key_experian_crdb_linkids);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_experian_crdb + '@version@::linkids', 
	 'Q', 
	 move_qa_key_experian_crdb_linkids);
	 
 is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
 NoUpdate           := OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
 updatedops         := PRTE.UpdateVersion('ExperianCRDBKeys', filedate, _control.MyInfo.EmailAddressNormal,'B','N','N');
 PerformUpdateOrNot := IF(is_running_in_prod,updatedops,NoUpdate);

	
	RETURN 		sequential(
	          build_key_experian_crdb_linkids,
	          move_built_key_experian_crdb_linkids,
						move_qa_key_experian_crdb_linkids);
						
						//PerformUpdateOrNot);
	

END;