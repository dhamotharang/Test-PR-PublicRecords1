import ut,RoxieKeyBuild,PRTE2_DEATH_MASTER,AutoKeyB2, promotesupers, strata,PRTE2_Common, _control,PRTE;
 
EXPORT Proc_Build_Keys(string filedate) := FUNCTION

//Build the custom non-SSA keys
proc_deathmaster_buildkey(string filedate) := function
	#uniquename(version_date)
	%version_date% := filedate;
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.Key_Death_MasterV2_Did, 
			constants.KeyName_death_master + 'did_death_masterV2',
			constants.KeyName_death_master + 'death_masterV2::'+%version_date%+'::did',a4);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_ssn(isFCRA := true), 
			constants.KeyName_death_master + 'fcra::death_master::ssn',
			constants.KeyName_death_master + 'fcra::death_master::'+%version_date%+'::ssn',a7);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_death_masterv2_did_fcra, 
			constants.KeyName_death_master + 'fcra::did_death_masterV2',
			constants.KeyName_death_master + 'fcra::death_masterV2::'+%version_date%+'::did',a9);
			
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'did_death_masterV2',
										constants.KeyName_death_master + 'death_masterV2::'+%version_date%+'::did', b4);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'fcra::death_master::ssn',
										constants.KeyName_death_master + 'fcra::death_master::'+%version_date%+'::ssn', b7);
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'fcra::did_death_masterV2',
										constants.KeyName_death_master + 'fcra::death_masterV2::'+%version_date%+'::did', b9);

	// add new keys in the build
	full1 := sequential(	parallel(a4,a7,a9),
								parallel(b4,b7,b9)

	);

	// Move keys to QA
	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'did_death_masterV2', 'Q', move4, 2);
	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'fcra::death_master::ssn', 'Q', move7, 2);
	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_death_master + 'fcra::did_death_masterV2', 'Q', move9, 2);

	move_qa	:=	parallel(move4,move7,move9);

	return sequential(full1,move_qa);
end;

//Build the custom SSA keys
proc_deathmaster_buildkey_ssa(string filedate) := function
	#uniquename(version_date)
	%version_date% := filedate;


	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.Key_Death_id_supplemental_ssa,
		constants.KeyName_death_master + 'death_id_death_supplemental_ssa',
		constants.KeyName_death_master + 'death_supplemental_ssa::'+%version_date%+'::death_id', a2);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.Key_dod_ssa, 
		constants.KeyName_death_master + 'dod_death_masterV2_ssa',
		constants.KeyName_death_master + 'death_masterV2_ssa::'+%version_date%+'::dod',a3);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.Key_Death_MasterV2_ssa_Did, 
		constants.KeyName_death_master + 'did_death_masterV2_ssa',
		constants.KeyName_death_master + 'death_masterV2_ssa::'+%version_date%+'::did',a4);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.Key_Death_id_base_ssa,
		constants.KeyName_death_master + 'death_id_death_masterV2_ssa',
		constants.KeyName_death_master + 'death_masterV2_ssa::'+%version_date%+'::death_id', a5);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.Key_dob_ssa, 
		constants.KeyName_death_master + 'dob_death_masterV2_ssa',
		constants.KeyName_death_master + 'death_masterV2_ssa::'+%version_date%+'::dob',a6);

	// build 2 copies of SSN Death key, one for FCRA and one for nonFCRA
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_ssn_ssa(isFCRA := true), 
		constants.KeyName_death_master + 'fcra::death_master_ssa::ssn',
		constants.KeyName_death_master + 'fcra::death_master_ssa::'+%version_date%+'::ssn',a7);
											
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_ssn_ssa(isFCRA := false), 
		constants.KeyName_death_master + 'death_master_ssa::ssn',
		constants.KeyName_death_master + 'death_master_ssa::'+%version_date%+'::ssn',a8);

	//FCRA Key built
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_death_masterV2_ssa_DID_fcra, 
											constants.KeyName_death_master + 'fcra::did_death_masterV2_ssa',
											constants.KeyName_death_master + 'fcra::death_masterV2_ssa::'+%version_date%+'::did',a9);




	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'death_id_death_supplemental_ssa',
										constants.KeyName_death_master + 'death_supplemental_ssa::'+%version_date%+'::death_id', b2);
							 
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'dod_death_masterV2_ssa',
										constants.KeyName_death_master + 'death_masterV2_ssa::'+%version_date%+'::dod', b3);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'did_death_masterV2_ssa',
										constants.KeyName_death_master + 'death_masterV2_ssa::'+%version_date%+'::did', b4);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'death_id_death_masterV2_ssa',
										constants.KeyName_death_master + 'death_masterV2_ssa::'+%version_date%+'::death_id', b5);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'dob_death_masterV2_ssa',
										constants.KeyName_death_master + 'death_masterV2_ssa::'+%version_date%+'::dob', b6);
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'fcra::death_master_ssa::ssn',
										constants.KeyName_death_master + 'fcra::death_master_ssa::'+%version_date%+'::ssn', b7);
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'death_master_ssa::ssn',
										constants.KeyName_death_master + 'death_master_ssa::'+%version_date%+'::ssn', b8);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2(constants.KeyName_death_master + 'fcra::did_death_masterV2_ssa',
										constants.KeyName_death_master + 'fcra::death_masterV2_ssa::'+%version_date%+'::did', b9);

	// add new keys in the build
	full1 := sequential(	parallel(a2,a3,a4,a5,a6,a7,a8,a9),
										parallel(b2,b3,b4,b5,b6,b7,b8,b9)
							
			);

	// Move keys to QA

	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'death_id_death_supplemental_ssa', 'Q', move2, 2);
	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'dod_death_masterV2_ssa', 'Q', move3, 2);
	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'did_death_masterV2_ssa', 'Q', move4, 2);
	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'death_id_death_masterV2_ssa', 'Q', move5, 2);
	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'dob_death_masterV2_ssa', 'Q', move6, 2);
	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'fcra::death_master_ssa::ssn', 'Q', move7, 2);
	promotesupers.Mac_SK_Move_v2(constants.KeyName_death_master + 'death_master_ssa::ssn', 'Q', move8, 2);
	///////////////////////// Move FCRA KEYS /////////////////////////
	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_death_master + 'fcra::did_death_masterV2_ssa', 'Q', move9, 2);

	move_qa	:=	parallel(move2,move3,move4,move5,move6,move7,move8,move9);

	return sequential(full1,move_qa);

end;


proc_autokeybuild_ssa(string filedate) := function

	dsearch_ssa := files.file_SearchAutokey_ssa;

	skip_set := constants.autokey_skip_set;


autokey_keyname		:=	constants.autokey_keyname_ssa;
autokey_logical		:=	constants.autokey_Logical_ssa(filedate);


AutoKeyB2.MAC_Build (dsearch_ssa,fname,mname,lname,
						ssn,
						dob,
						zero,
						addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						DID,
						//personal above.  business below
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						autokey_keyname,
						autokey_logical,
						outaction,false,
						skip_set,TRUE,constants.autokey_typeStr,
						true,,,zero); 


AutoKeyB2.MAC_AcceptSK_to_QA(autokey_keyname,mymove,,skip_set)

out_auto := sequential(outaction, mymove);
 
return out_auto;
END;

//DF-22303: FCRA Consumer Data Field Depreciation:FCRA_DeathMasterSSAKeys
cnt_fcra_ssa_ssn := OUTPUT(strata.macf_pops(keys.key_ssn_ssa(TRUE),,,,,,FALSE,
															 ['st_country_code','zip_lastpayment']), named('cnt_fcra_ssa_ssn'));
															 

// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
DOPS_Comment		 				:= OUTPUT('Skipping DOPS process');
updatedops							:= PRTE.UpdateVersion('DeathMasterKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
updatedops_ssa					:= PRTE.UpdateVersion('DeathMasterSSAKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
updatedops_fcra					:= PRTE.UpdateVersion('FCRA_DeathMasterKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
updatedops_ssa_fcra			:= PRTE.UpdateVersion('FCRA_DeathMasterSSAKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
															 

RETURN SEQUENTIAL(PARALLEL(proc_deathmaster_buildkey(filedate),proc_deathmaster_buildkey_ssa(filedate),
									proc_autokeybuild_ssa(filedate),
									cnt_fcra_ssa_ssn,
									IF(not is_running_in_prod, DOPS_Comment, parallel(updatedops,updatedops_ssa,updatedops_fcra,updatedops_ssa_fcra))  
									));
end;