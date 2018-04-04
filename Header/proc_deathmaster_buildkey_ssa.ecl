import header,codes,did_add,didville,ut,header_slimsort,watchdog,doxie_files,roxiekeybuild,Risk_Indicators,doxie, death_master, promotesupers,strata;

export proc_deathmaster_buildkey_ssa(string filedate) := function
	#uniquename(version_date)
	%version_date% := filedate;

	pre1 := promotesupers.SF_MaintBuilding('~thor_data400::base::did_death_master_ssa');
	pre2 := promotesupers.SF_MaintBuilding('~thor_data400::base::did_death_masterV2_ssa');


	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Death_Master_ssa_Did,'~thor_data400::key::did_death_master_ssa',
											'~thor_data400::key::death_master_ssa::'+%version_date%+'::did', a1);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(death_master.Key_Death_id_supplemental_ssa,'~thor_data400::key::death_id_death_supplemental_ssa',
											'~thor_data400::key::death_supplemental_ssa::'+%version_date%+'::death_id', a2);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(death_master.Key_dod_ssa, '~thor_data400::key::dod_death_masterV2_ssa',
											'~thor_data400::key::death_masterV2_ssa::'+%version_date%+'::dod',a3);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Death_MasterV2_ssa_Did, '~thor_data400::key::did_death_masterV2_ssa',
											'~thor_data400::key::death_masterV2_ssa::'+%version_date%+'::did',a4);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(death_master.Key_Death_id_base_ssa,'~thor_data400::key::death_id_death_masterV2_ssa',
											'~thor_data400::key::death_masterV2_ssa::'+%version_date%+'::death_id', a5);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(death_master.Key_dob_ssa, '~thor_data400::key::dob_death_masterV2_ssa',
											'~thor_data400::key::death_masterV2_ssa::'+%version_date%+'::dob',a6);

	// build 2 copies of SSN Death key, one for FCRA and one for nonFCRA
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Death_Master.key_ssn_ssa(isFCRA := true), '~thor_data400::key::fcra::death_master_ssa::ssn',
											'~thor_data400::key::fcra::death_master_ssa::'+%version_date%+'::ssn',a7);
											
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Death_Master.key_ssn_ssa(isFCRA := false), '~thor_data400::key::death_master_ssa::ssn',
											'~thor_data400::key::death_master_ssa::'+%version_date%+'::ssn',a8);

	//FCRA Key built
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Doxie.key_death_masterV2_ssa_DID_fcra, 
											'~thor_data400::key::fcra::did_death_masterV2_ssa',
											'~thor_data400::key::fcra::death_masterV2_ssa::'+%version_date%+'::did',a9);



	//change macro superkey build V2 for death_id, fname and DOD and new DID keys
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::did_death_master_ssa',
										'~thor_data400::key::death_master_ssa::'+%version_date%+'::did', b1);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::death_id_death_supplemental_ssa',
										'~thor_data400::key::death_supplemental_ssa::'+%version_date%+'::death_id', b2);
							 
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dod_death_masterV2_ssa',
										'~thor_data400::key::death_masterV2_ssa::'+%version_date%+'::dod', b3);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::did_death_masterV2_ssa',
										'~thor_data400::key::death_masterV2_ssa::'+%version_date%+'::did', b4);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::death_id_death_masterV2_ssa',
										'~thor_data400::key::death_masterV2_ssa::'+%version_date%+'::death_id', b5);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dob_death_masterV2_ssa',
										'~thor_data400::key::death_masterV2_ssa::'+%version_date%+'::dob', b6);
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::death_master_ssa::ssn',
										'~thor_data400::key::fcra::death_master_ssa::'+%version_date%+'::ssn', b7);
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::death_master_ssa::ssn',
										'~thor_data400::key::death_master_ssa::'+%version_date%+'::ssn', b8);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::did_death_masterV2_ssa',
										'~thor_data400::key::fcra::death_masterV2_ssa::'+%version_date%+'::did', b9);

	// add new keys in the build
	full1 := if(	fileservices.getsuperfilesubname('~thor_data400::base::did_death_master_ssa',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_death_master_ssa_built',1) and
								fileservices.getsuperfilesubname('~thor_data400::base::did_death_masterV2_ssa',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_death_masterV2_ssa_built',1), 
								output('main file BASE = BUILT, Nothing done.'), 
								sequential(	parallel(a1,a2,a3,a4,a5,a6,a7,a8,a9),
														parallel(b1,b2,b3,b4,b5,b6,b7,b8,b9)
													)
							);

	// Move keys to QA
	promotesupers.mac_sk_move_v2('~thor_data400::key::did_death_master_ssa', 'Q', move1, 2);
	promotesupers.mac_sk_move_v2('~thor_data400::key::death_id_death_supplemental_ssa', 'Q', move2, 2);
	promotesupers.mac_sk_move_v2('~thor_data400::key::dod_death_masterV2_ssa', 'Q', move3, 2);
	promotesupers.mac_sk_move_v2('~thor_data400::key::did_death_masterV2_ssa', 'Q', move4, 2);
	promotesupers.mac_sk_move_v2('~thor_data400::key::death_id_death_masterV2_ssa', 'Q', move5, 2);
	promotesupers.mac_sk_move_v2('~thor_data400::key::dob_death_masterV2_ssa', 'Q', move6, 2);
	promotesupers.mac_sk_move_v2('~thor_data400::key::fcra::death_master_ssa::ssn', 'Q', move7, 2);
	promotesupers.mac_sk_move_v2('~thor_data400::key::death_master_ssa::ssn', 'Q', move8, 2);
	///////////////////////// Move FCRA KEYS /////////////////////////
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::fcra::did_death_masterV2_ssa', 'Q', move9, 2);

	// DF-21696 Show counts of blanked out fields in thor_data400::key::fcra::did_death_masterv2_ssa_qa
	cnt_death_masterv2_ssa_did_key_fcra := OUTPUT(strata.macf_pops(Doxie.key_death_masterv2_ssa_did_fcra,,,,,,FALSE,['st_country_code','zip_lastpayment']));


	move_qa	:=	parallel(move1,move2,move3,move4,move5,move6,move7,move8,move9);

	// Move building to built
	post1 := promotesupers.SF_MaintBuilding('~thor_data400::base::did_death_master_ssa');  
	post2 := promotesupers.SF_MaintBuilding('~thor_data400::base::did_death_masterV2_ssa');

	return sequential(pre1,pre2,full1,move_qa,cnt_death_masterv2_ssa_did_key_fcra,post1,post2);
end;