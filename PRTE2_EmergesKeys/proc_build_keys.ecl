IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control,strata, PRTE2_Common ;

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
	
	cnt_emerges_hunt_rid_fcra := OUTPUT(strata.macf_pops(prte2_eMergesKeys.keys.key_hunters_rid(TRUE),,,,,,FALSE,
																	['ace_fips_st', 'active_other', 'active_status', 'agecat', 'antelope', 'anterless', 'archery', 'bear'
																		,'biggame', 'bighorn', 'blind', 'bonus', 'buffalo', 'combosuper', 'cougar', 'crewmemeber'
																		,'day1', 'day14to15', 'day3', 'day7', 'dayfiller', 'deer', 'disabled', 'drawing'
																		,'duck', 'elk', 'fallfishing', 'family', 'fish', 'freshwater', 'goose', 'gun'
																		,'headhousehold', 'historyfiller', 'hunt', 'huntfill1', 'huntfiller', 'indian', 'javelina', 'junior'
																		,'lakesandresevoirs', 'landowner', 'lifetimepermit', 'lottery', 'lowincome', 'maiden_name', 'maiden_prior', 'mail_ace_fips_st'
																		,'mail_ace_zip', 'mail_addr_suffix', 'mail_addr1', 'mail_addr2', 'mail_cart', 'mail_chk_digit', 'mail_city'
																		,'mail_county', 'mail_cr_sort_sz', 'mail_dpbc', 'mail_err_stat', 'mail_fipscounty', 'mail_geo_blk', 'mail_geo_lat'
																		,'mail_geo_long', 'mail_geo_match', 'mail_lot', 'mail_lot_order', 'mail_msa', 'mail_p_city_name', 'mail_postdir'
																		,'mail_predir', 'mail_prim_name', 'mail_prim_range', 'mail_record_type', 'mail_sec_range', 'mail_st', 'mail_state'
																		,'mail_unit_desig', 'mail_v_city_name', 'mail_zip', 'mail_zip4', 'migbird', 'moose', 'motorvoterid'
																		,'muzzle', 'nonresident', 'occupation', 'other_phone', 'otherbirds', 'pheasant', 'phone', 'place_of_birth'
																		,'poliparty', 'race', 'record_type', 'regdate', 'regioncounty', 'regsource', 'res_county', 'resident'
																		,'retarded', 'salmon', 'saltwater', 'seasonannual', 'seniorcit', 'serviceman', 'setlinefish', 'shellfishcrab'
																		,'shellfishlobster', 'sikebull', 'skipass', 'smallgame', 'snowmobile', 'source_voterid', 'sportsman', 'steelhead'
																		,'sturgeon', 'sturgeon2', 'trap', 'trout', 'turkey', 'votefiller', 'votefiller2', 'voterstatus'
																		,'whitejubherring', 'work_phone']), named('cnt_emerges_hunt_rid_fcra'));  

	cnt_emerges_doxie_did_fcra := OUTPUT(strata.macf_pops(prte2_eMergesKeys.keys.key_hunters_doxie_did(TRUE),,,,,,FALSE,
																		['ace_fips_st','active_other','active_status','agecat','antelope','anterless','archery','bear','biggame'
																		,'bighorn','blind','bonus','buffalo','combosuper','cougar','crewmemeber','day1','day14to15','day3','day7','dayfiller'
																		,'deer','disabled','drawing','duck','elk','fallfishing','family','fish','freshwater','goose','gun','headhousehold'
																		,'historyfiller','hunt','huntfill1','huntfiller','indian','javelina','junior','lakesandresevoirs','landowner'
																		,'lifetimepermit','lottery','lowincome','maiden_name','maiden_prior','mail_ace_fips_st','mail_ace_zip'
																		,'mail_addr_suffix','mail_addr1','mail_addr2','mail_cart','mail_chk_digit','mail_city','mail_county','mail_cr_sort_sz'
																		,'mail_dpbc','mail_err_stat','mail_fipscounty','mail_geo_blk','mail_geo_lat','mail_geo_long','mail_geo_match'
																		,'mail_lot','mail_lot_order','mail_msa','mail_p_city_name','mail_postdir','mail_predir','mail_prim_name'
																		,'mail_prim_range','mail_record_type','mail_sec_range','mail_st','mail_state','mail_unit_desig','mail_v_city_name'
																		,'mail_zip','mail_zip4','migbird','moose','motorvoterid','muzzle','nonresident','occupation','other_phone'
																		,'otherbirds','pheasant','phone','place_of_birth','poliparty','race','record_type','regdate','regioncounty'
																		,'regsource','res_county','resident','retarded','salmon','saltwater','seasonannual','eniorcit','serviceman'
																		,'setlinefish','shellfishcrab','shellfishlobster','sikebull','skipass','smallgame','snowmobile','source_voterid'
																		,'sportsman','steelhead','sturgeon','sturgeon2','trap','trout','turkey','votefiller','votefiller2','voterstatus'
																		,'whitejubherring','work_phone']), named('cnt_emerges_doxie_did_fcra'));


//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops   		 		:= PRTE.UpdateVersion('EmergesKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_EmergesKeysKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);


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
			 proc_build_autokeys.hunters_autokeys(filedate),
			 parallel(cnt_emerges_hunt_rid_fcra,cnt_emerges_doxie_did_fcra),
			 PerformUpdateOrNot
			 );
															
END;
