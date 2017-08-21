import header,codes,did_add,didville,ut,header_slimsort,watchdog,doxie_files,roxiekeybuild,Risk_Indicators,doxie, death_master,promotesupers;

export proc_deathmaster_buildkey(string filedate) := function
	#uniquename(version_date)
	%version_date% := filedate;

	pre1 := promotesupers.SF_MaintBuilding('~thor_data400::base::did_death_master');
	pre2 := promotesupers.SF_MaintBuilding('~thor_data400::base::did_death_masterV2');


	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Death_Master_Did,'~thor_data400::key::did_death_master',
											'~thor_data400::key::death_master::'+%version_date%+'::did', a1);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(death_master.Key_Death_id_supplemental,'~thor_data400::key::death_id_death_supplemental',
											'~thor_data400::key::death_supplemental::'+%version_date%+'::death_id', a2);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(death_master.Key_dod, '~thor_data400::key::dod_death_masterV2',
											'~thor_data400::key::death_masterV2::'+%version_date%+'::dod',a3);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Death_MasterV2_Did, '~thor_data400::key::did_death_masterV2',
											'~thor_data400::key::death_masterV2::'+%version_date%+'::did',a4);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(death_master.Key_Death_id_base,'~thor_data400::key::death_id_death_masterV2',
											'~thor_data400::key::death_masterV2::'+%version_date%+'::death_id', a5);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(death_master.Key_dob, '~thor_data400::key::dob_death_masterV2',
											'~thor_data400::key::death_masterV2::'+%version_date%+'::dob',a6);

	// build 2 copies of SSN Death key, one for FCRA and one for nonFCRA
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Death_Master.key_ssn(isFCRA := true), '~thor_data400::key::fcra::death_master::ssn',
											'~thor_data400::key::fcra::death_master::'+%version_date%+'::ssn',a7);
											
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Death_Master.key_ssn(isFCRA := false), '~thor_data400::key::death_master::ssn',
											'~thor_data400::key::death_master::'+%version_date%+'::ssn',a8);

	//FCRA Key built
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Doxie.key_death_masterV2_DID_fcra, 
											'~thor_data400::key::fcra::did_death_masterV2',
											'~thor_data400::key::fcra::death_masterV2::'+%version_date%+'::did',a9);



	//change macro superkey build V2 for death_id, fname and DOD and new DID keys
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::did_death_master',
										'~thor_data400::key::death_master::'+%version_date%+'::did', b1);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::death_id_death_supplemental',
										'~thor_data400::key::death_supplemental::'+%version_date%+'::death_id', b2);
							 
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dod_death_masterV2',
										'~thor_data400::key::death_masterV2::'+%version_date%+'::dod', b3);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::did_death_masterV2',
										'~thor_data400::key::death_masterV2::'+%version_date%+'::did', b4);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::death_id_death_masterV2',
										'~thor_data400::key::death_masterV2::'+%version_date%+'::death_id', b5);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dob_death_masterV2',
										'~thor_data400::key::death_masterV2::'+%version_date%+'::dob', b6);
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::death_master::ssn',
										'~thor_data400::key::fcra::death_master::'+%version_date%+'::ssn', b7);
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::death_master::ssn',
										'~thor_data400::key::death_master::'+%version_date%+'::ssn', b8);

	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::did_death_masterV2',
										'~thor_data400::key::fcra::death_masterV2::'+%version_date%+'::did', b9);

	// add new keys in the build
	full1 := if(	fileservices.getsuperfilesubname('~thor_data400::base::did_death_master',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_death_master_built',1) and
								fileservices.getsuperfilesubname('~thor_data400::base::did_death_masterV2',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_death_masterV2_built',1), 
								output('main file BASE = BUILT, Nothing done.'), 
								sequential(	parallel(a1,a2,a3,a4,a5,a6,a7,a8,a9),
														parallel(b1,b2,b3,b4,b5,b6,b7,b8,b9)
													)
							);

	// Move keys to QA
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::did_death_master', 'Q', move1, 2);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::death_id_death_supplemental', 'Q', move2, 2);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::dod_death_masterV2', 'Q', move3, 2);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::did_death_masterV2', 'Q', move4, 2);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::death_id_death_masterV2', 'Q', move5, 2);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::dob_death_masterV2', 'Q', move6, 2);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::fcra::death_master::ssn', 'Q', move7, 2);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::death_master::ssn', 'Q', move8, 2);
	///////////////////////// Move FCRA KEYS /////////////////////////
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::fcra::did_death_masterV2', 'Q', move9, 2);

	move_qa	:=	parallel(move1,move2,move3,move4,move5,move6,move7,move8,move9);

	// Move building to built
	post1 := promotesupers.SF_MaintBuilt('~thor_data400::base::did_death_master');  
	post2 := promotesupers.SF_MaintBuilt('~thor_data400::base::did_death_masterV2');

	RETURN SEQUENTIAL(pre1,pre2,full1,move_qa,post1,post2);
end;