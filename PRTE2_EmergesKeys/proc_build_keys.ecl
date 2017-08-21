IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control;

EXPORT proc_build_keys(string filedate) := FUNCTION
//build_key_ccw_did
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_CCW_Did(false),
 	 constants.KeyName_CCW + '@version@::did',
	constants.keyname_CCW + filedate + '::did', build_key_ccw_did);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_CCW + '@version@::did', 
	constants.KeyName_CCW + filedate + '::did',
	move_built_key_ccw_did);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.keyName_CCW + '@version@::did', 
	'Q', 
	move_qa_key_ccw_did);
	
	//build_key_ccwfcra_did
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys.Key_CCW_Did(true),
	constants.KeyName_CCW + 'fcra::' +  '@version@::did',
	constants.KeyName_CCW + 'fcra::' + filedate + '::did', build_key_ccwfcra_did);
	
 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_CCW + 'fcra::' + '@version@::did', 
 constants.KeyName_CCW + 'fcra::' +  filedate + '::did',
 move_built_key_ccwfcra_did);

 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_CCW + 'fcra::' + '@version@::did', 
 'Q', 
 move_qa_key_ccwfcra_did);
 
 
 //build_key_hunting_fishing_did
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hunting_fishing_did(false),
	constants.KeyName_Hunting + '@version@::did',
	constants.keyName_Hunting +  filedate + '::did', build_key_hunting_fishing_did);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_Hunting + '@version@::did', 
		constants.KeyName_hunting +  filedate + '::did',
		move_built_key_hunting_fishing_did);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_Hunting + '@version@::did', 
	 'Q', 
	move_qa_key_hunting_fishing_did);
	
//build_key_hunting_fishingfcra_did	
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hunting_fishing_did(true),
 constants.KeyName_Hunting + 'fcra::' + '@version@::did',
  constants.KeyName_Hunting + 'fcra::' +  filedate + '::did', build_key_hunting_fishingfcra_did);
   
  RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_Hunting + 'fcra::' + '@version@::did', 
	 constants.keyName_Hunting + 'fcra::' + filedate + '::did',
		move_built_key_hunting_fishingfcra_did);
			
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_Hunting + 'fcra::' + '@version@::did', 
		 'Q', 
	 move_qa_key_hunting_fishingfcra_did);
		
	
//build_key_ccw_rid	
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ccw_rid(false),
	constants.KeyName_CCW + '@version@::rid',
		constants.KeyName_CCW +  filedate + '::rid', build_key_ccw_rid);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_CCW + '@version@::rid', 
		constants.KeyName_CCW + filedate + '::rid',
		move_built_key_ccw_rid);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_CCW + '@version@::rid', 
		'Q', 
	move_qa_key_ccw_rid);	
	
	
//build_key_ccwfcra_rid
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ccw_rid(true),
	constants.KeyName_CCW + 'fcra::' + '@version@::rid',
		constants.KeyName_CCW + 'fcra::' +  filedate + '::rid', build_key_ccwfcra_rid);	
	
	 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_CCW + 'fcra::' + '@version@::rid', 
	 constants.KeyName_CCW + 'fcra::' +  filedate + '::rid',
	 move_built_key_ccwfcra_rid);
	
  RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_CCW + 'fcra::' + '@version@::rid', 
	  'Q', 
  move_qa_key_ccwfcra_rid);

 	//build_key_ccw_doxie_did
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ccw_doxie_did(false),
	constants.KeyName_CCW_Doxie_Did + '@version@',
	constants.KeyName_Emerges +  filedate + '::ccw_doxie_did', build_key_ccw_doxie_did);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_CCW_Doxie_Did + '@version@', 
		constants.KeyName_Emerges +  filedate + '::ccw_doxie_did',
		move_built_key_ccw_doxie_did);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_CCW_Doxie_Did + '@version@', 
	'Q', 
	move_qa_key_ccw_doxie_did);
	
	//build_key_ccw_doxie_did_fcra
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ccw_doxie_did(true),
	constants.KeyName_CCW_doxie_did_FCRA +'@version@',
	constants.KeyName_Emerges +  filedate + '::ccw_doxie_did_fcra', build_key_ccw_doxie_did_fcra);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_CCW_doxie_did_FCRA + '@version@', 
	constants.KeyName_Emerges + filedate + '::ccw_doxie_did_fcra',
	move_built_key_ccw_doxie_did_fcra);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_CCW_doxie_Did_FCRA + '@version@', 
	'Q', 
	move_qa_key_ccw_doxie_did_fcra);
	
	//build_key_hunters_doxie_did
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hunters_doxie_did (false),
	constants.KeyName_Hunting_Doxie_did + '@version@',
	constants.KeyName_Emerges +  filedate + '::hunters_doxie_did', build_key_hunters_doxie_did);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_Hunting_Doxie_did + '@version@', 
	constants.KeyName_Emerges +  filedate + '::hunters_doxie_did',
	move_built_key_hunters_doxie_did);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_Hunting_Doxie_did + '@version@', 
	'Q', 
	move_qa_key_hunters_doxie_did);
	
	//build_key_hunters_doxie_did_fcra
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hunters_doxie_did(true),
	 constants.KeyName_Hunting_doxie_did_FCRA + '@version@',
	 constants.KeyName_Emerges +  filedate + '::hunters_doxie_did_fcra', build_key_hunters_doxie_did_fcra);
		 
	 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_Hunting_doxie_did_FCRA + '@version@', 
	 constants.KeyName_Emerges + filedate + '::hunters_doxie_did_fcra',
	  move_built_key_hunters_doxie_did_fcra);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_Hunting_doxie_did_FCRA + '@version@', 
	  'Q', 
	 move_qa_key_hunters_doxie_did_fcra);
		
	//build_key_hunting_fishing_rid
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hunters_rid(false),
	constants.KeyName_Hunting + '@version@::rid',
		constants.KeyName_hunting +  filedate + '::rid', build_key_hunting_fishing_rid);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_Hunting + '@version@::rid', 
		constants.KeyName_Hunting +  filedate + '::rid',
	move_built_key_hunting_fishing_rid);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_Hunting + '@version@::rid', 
	'Q', 
	move_qa_key_hunting_fishing_rid);
	
	//build_key_hunting_fishingfcra_rid
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_hunters_rid(true),
	constants.KeyName_Hunting + 'fcra::' + '@version@::rid',
		constants.KeyName_Hunting + 'fcra::'  +  filedate + '::rid', build_key_hunting_fishingfcra_rid);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_Hunting + 'fcra::' + '@version@::rid', 
		 constants.KeyName_Hunting + 'fcra::' +   filedate + '::rid',
		 move_built_key_hunting_fishingfcra_rid);
	 
	RoxieKeyBuild.MAC_SK_Move_v2(constants.keyName_hunting + 'fcra::' + '@version@::rid', 
	'Q', 
	move_qa_key_hunting_fishingfcra_rid);
	
RETURN sequential(build_key_ccw_did, 
			 build_key_ccw_rid, 
			 build_key_ccw_doxie_did, 
			 build_key_hunting_fishing_did, 
			 build_key_hunting_fishing_rid, 
			 build_key_hunters_doxie_did, 
			 build_key_ccwfcra_did, 
			 build_key_ccwfcra_rid, 
			 build_key_ccw_doxie_did_fcra, 
			 build_key_hunters_doxie_did_fcra, 
			 build_key_hunting_fishingfcra_did, 
			 build_key_hunting_fishingfcra_rid, 
			 move_built_key_ccw_did, 
			 move_built_key_ccw_rid, 
			 move_built_key_ccw_doxie_did, 
			 move_built_key_hunting_fishing_did, 
			 move_built_key_hunting_fishing_rid,
			 move_built_key_hunters_doxie_did, 
			 move_built_key_ccwfcra_did, 
			 move_built_key_ccwfcra_rid, 
			 move_built_key_ccw_doxie_did_fcra, 
			 move_built_key_hunters_doxie_did_fcra, 
			 move_built_key_hunting_fishingfcra_did, 
			 move_built_key_hunting_fishingfcra_rid, 
			 move_qa_key_ccw_did,
			 move_qa_key_ccw_rid, 
			 move_qa_key_ccw_doxie_did, 
			 move_qa_key_hunting_fishing_did, 
			 move_qa_key_hunting_fishing_rid,
			 move_qa_key_hunters_doxie_did,
			 move_qa_key_ccwfcra_did,
			 move_qa_key_ccwfcra_rid, 
			 move_qa_key_ccw_doxie_did_fcra, 
			 move_qa_key_hunters_doxie_did_fcra, 
			 move_qa_key_hunting_fishingfcra_did, 
			 move_qa_key_hunting_fishingfcra_rid,
			 proc_build_autokeys.ccw_autokeys(filedate),
			 proc_build_autokeys.hunters_autokeys(filedate));
															
END;
