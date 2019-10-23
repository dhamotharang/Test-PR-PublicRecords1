IMPORT ut,RoxieKeyBuild,PRTE,_control;

EXPORT proc_build_keys(string filedate) := FUNCTION

 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_did,
 	constants.key_name + '@version@',
	constants.key_Name_Part_1 + filedate + constants.key_Name_Part_2, build_ssn);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_name + '@version@', 
	constants.key_Name_Part_1 + filedate + constants.key_Name_Part_2,
	move_ssn);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.key_name + '@version@', 
	 'Q', 
	move_qa_ssn);
		
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_did_file,
	constants.key_name_did + '@version@',
	constants.key_Name_Part_1_did + filedate + constants.key_Name_Part_2_did, build_did_file);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_name_did + '@version@', 
	constants.key_Name_Part_1_did + filedate + constants.key_Name_Part_2_did,
	move_did_file);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.key_name_did + '@version@', 
	 'Q', 
	move_qa_did_file);
	
	
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dln,
	constants.key_name_dln + '@version@',
	constants.key_Name_Part_1_dln + filedate + constants.key_Name_Part_2_dln, build_dln);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_name_dln + '@version@', 
	constants.key_Name_Part_1_dln + filedate + constants.key_Name_Part_2_dln,
	move_dln);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.key_name_dln + '@version@', 
	 'Q', 
	move_qa_dln);
	 
	 RETURN sequential(
      build_ssn, 
			move_ssn, 
			move_qa_ssn,
			build_did_file,
			move_did_file,
			move_qa_did_file,
			build_dln,
			move_dln,
			move_qa_dln);
																
 End;
