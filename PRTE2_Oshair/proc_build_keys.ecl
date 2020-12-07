IMPORT ut,RoxieKeyBuild, AutoKeyB2, PRTE,_control, PRTE2_Oshair, PRTE2_Common, Prte2, dops;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.linkids.key,
  constants.KeyName_oshair + 'linkids_@version@',
	constants.KeyName_oshair + filedate + '::linkids', build_key_oshairlinkids);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_oshairaccident,
	constants.KeyName_oshair + 'accident_@version@',
	constants.KeyName_oshair + filedate + '::accident', build_key_oshairaccident);
	
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_oshairinspection,
	constants.KeyName_oshair + 'inspection_@version@',
	constants.KeyName_oshair + filedate + '::inspection', build_key_oshairinspection);
	
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_oshairviolations,
	 constants.KeyName_oshair + 'violations_@version@',
	 constants.KeyName_oshair + filedate + '::violations', build_key_oshairviolations);
	 
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_oshairhazardous_substance,
 	constants.KeyName_oshair + 'hazardous_substance_@version@',
  constants.KeyName_oshair + filedate + '::hazardous_substance',build_key_oshairhazardous_substance);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_oshairbdid,
  constants.KeyName_oshair + 'bdid_@version@',
  constants.KeyName_oshair + filedate + '::bdid', build_key_oshairbdid);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_oshairprogram,
	 constants.keyname_oshair + 'program_@version@',
	 constants.keyname_oshair + filedate + '::program', build_key_oshairprogram);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_oshair + 'accident_@version@', 
	constants.KeyName_oshair + filedate + '::accident',
	move_built_key_oshairaccident);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_oshair + 'inspection_@version@', 
	constants.KeyName_oshair + filedate + '::inspection',
	move_built_key_oshairinspection);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_oshair + 'violations_@version@', 
	 constants.KeyName_oshair + filedate + '::violations',
	 move_built_key_oshairviolations);
	 
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.keyName_oshair + 'hazardous_substance_@version@', 
	 constants.KeyName_oshair + filedate + '::hazardous_substance',
	 move_built_key_oshairhazardous_substance);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.keyName_oshair + 'bdid_@version@', 
 constants.keyName_oshair + filedate + '::bdid',
 move_built_key_oshairbdid);
 
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.keyName_oshair + 'linkids_@version@', 
	constants.keyName_oshair + filedate + '::linkids',
	 move_built_key_oshairlinkids);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.keyName_oshair + 'program_@version@', 
 constants.keyName_oshair + filedate + '::program',
 move_built_key_oshairprogram);

RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_oshair + 'accident_@version@', 
	'Q', 
	move_qa_key_oshairaccident);
	
RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_oshair + 'inspection_@version@', 
	'Q', 
	move_qa_key_oshairinspection);
	
RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_oshair + 'violations_@version@', 
	 'Q', 
	 move_qa_key_oshairviolations);
	 
RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_oshair + 'hazardous_substance_@version@', 
	 'Q', 
	 move_qa_key_oshairhazardous_substance);

RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_oshair + 'bdid_@version@', 
 'Q', 
 move_qa_key_oshairbdid);
 
RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_oshair + 'linkids_@version@', 
	 'Q', 
	 move_qa_key_oshairlinkids);

RoxieKeyBuild.MAC_SK_Move_v2(constants.keyName_oshair + 'program_@version@', 
 'Q', 
 move_qa_key_oshairprogram);

		
//---------- making DOPS optional and only in PROD build -------------------------------
 is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
 NoUpdate           := OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
 
  updatedops   		 		:= PRTE.UpdateVersion(constants.dops_name,filedate,_control.MyInfo.EmailAddressNormal,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
 PerformUpdateOrNot := IF(is_running_in_prod,updatedops,NoUpdate);
 
 	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));

RETURN 		sequential(
      parallel(
      build_key_oshairaccident, 
			build_key_oshairbdid, 
			build_key_oshairhazardous_substance, 
			build_key_oshairinspection, 
			build_key_oshairlinkids, 
			build_key_oshairprogram, 
			build_key_oshairviolations), 
			parallel(
			move_built_key_oshairaccident, 
			move_built_key_oshairbdid, 
			move_built_key_oshairhazardous_substance, 
			move_built_key_oshairinspection, 
			move_built_key_oshairlinkids, 
			move_built_key_oshairprogram, 
			move_built_key_oshairviolations), 
			parallel(
			move_qa_key_oshairaccident, 
			move_qa_key_oshairbdid, 
			move_qa_key_oshairhazardous_substance, 
			move_qa_key_oshairinspection, 
			move_qa_key_oshairlinkids, 
			move_qa_key_oshairprogram, 
			move_qa_key_oshairviolations,	
			proc_build_autokeys(filedate)),
			key_validation,
			PerformUpdateOrNot
			);
																
END;
