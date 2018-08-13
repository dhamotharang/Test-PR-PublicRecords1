IMPORT PRTE2_DEATH_MASTER, doxie,mdr,ut;
EXPORT keys := MODULE

	EXPORT Key_Death_Master_ssa_Did 	:= index(FILES.DID_Dead_With_County(TRUE)((unsigned6)did != 0),
                               {unsigned6 l_did := (integer)did},{FILES.Death_Master_DID(TRUE)},
				           constants.KeyName_death_master + 'did_death_master_ssa_'+doxie.Version_SuperKey);

	EXPORT Key_Death_id_supplemental_ssa:= index(files.DEATH_MASTER_SUPPLEMENTAL_SSA,
                               {state_death_id},{files.DEATH_MASTER_SUPPLEMENTAL_SSA},
				           constants.KeyName_death_master + 'death_id_death_supplemental_ssa'+ doxie.Version_SuperKey);

	EXPORT key_death_masterv2_did := index(FILES.Building_Dead_With_County(false)((unsigned6)did != 0),
                           {unsigned6 l_did := (integer)did},{FILES.Building_Dead_With_County(false)},
				           constants.KeyName_death_master + 'did_death_masterv2_'+doxie.Version_SuperKey);
	
	EXPORT key_ssn(boolean isFCRA) := function
		fcra_base := Files.File_DeathMaster_Building((LENGTH(TRIM(ssn))=9) and trim(src) = mdr.sourceTools.src_Death_Master and glb_flag != 'Y');

		base := if(isFCRA, fcra_base, files.File_DeathMaster_Building((LENGTH(TRIM(ssn))=9)));

		key_name := if(isFCRA, 
			constants.KeyName_death_master + 'fcra::death_master::ssn_'+ doxie.Version_SuperKey,
			constants.KeyName_death_master + 'death_master::ssn_'+ doxie.Version_SuperKey
		);

		return index(base,{ssn},{base},key_name);
	
	END;
	
			
	EXPORT key_death_masterv2_did_fcra := index(Files.Bldg_Dead_With_County_FCRA(FALSE),
			   {unsigned6 l_did := (integer)did},{Files.Bldg_Dead_With_County_FCRA(FALSE)},
			   constants.KeyName_death_master + 'fcra::did_death_masterv2_'+doxie.Version_SuperKey);


	EXPORT key_death_masterv2_ssa_did_fcra := Index(Files.Bldg_Dead_With_County_FCRA(TRUE),
		{unsigned6 l_did := (integer)did},{Files.Bldg_Dead_With_County_FCRA(TRUE)},
		constants.KeyName_death_master + 'fcra::did_death_masterv2_ssa_'+doxie.Version_SuperKey);

	EXPORT key_dod_ssa := index(
		files.slim_dod_ssa,
		{dod8, state, dph_lname, pfname},
		{state_death_id},
		constants.KeyName_death_master + 'dod_death_masterV2_ssa_' + doxie.Version_SuperKey
	);
	
	EXPORT key_death_masterv2_ssa_did := index(Files.Building_Dead_With_County(TRUE)((unsigned6)did != 0),
			{unsigned6 l_did := (integer)did},{Files.Building_Dead_With_County(TRUE)},
			constants.KeyName_death_master + 'did_death_masterv2_ssa_'+doxie.Version_SuperKey);
	EXPORT key_death_id_base_ssa := index(files.Building_Dead_With_County(TRUE),
            {state_death_id},{files.Building_Dead_With_County(TRUE)},
			constants.KeyName_death_master + 'death_id_death_masterV2_ssa_'+doxie.Version_SuperKey);

	EXPORT key_dob_ssa := index(
		files.File_DeathMaster_DOB_SSA,
		{dob8, state, dph_lname, pfname},
		{state_death_id},
		constants.KeyName_death_master + 'dob_death_masterV2_ssa_' + doxie.Version_SuperKey
		);
		
	EXPORT key_ssn_ssa(boolean isFCRA) := function

			dm_base := files.File_DeathMaster_Building(LENGTH(TRIM(ssn))=9);
			// for reference, this is the list of the new sources being added to Death Master
			// which we want to make sure are excluded from FCRA key until shell 5.0 goes live
			// src_Death_Tributes 	:= 'TR';
			// src_Death_CA				:= 'D0';
			// src_Death_GA				:= 'D3';
			// src_Death_MI				:= 'D7';
			// src_Death_MT				:= 'D9';
			// src_Death_NV				:= 'D#';
			// src_Death_OH				:= 'D@';
			set_temp_fcra_exclude := [
				mdr.sourcetools.src_Death_Tributes,
				mdr.sourceTools.src_Death_CA,
				mdr.sourceTools.src_Death_GA,
				mdr.sourceTools.src_Death_MI,
				mdr.sourceTools.src_Death_MT,
				mdr.sourceTools.src_Death_NV,
				mdr.sourceTools.src_Death_OH
			];
			
			//DF-22303: FCRA Consumer Data Field Depreciation:FCRA_DeathMasterSSAKeys
			ut.MAC_CLEAR_FIELDS(dm_base, dm_base_cleared, prte2_death_master.constants.fields_to_clear);
			
			// to match what we have in SSN Table for now, only use DE source for FCRA	
			fcra_base := dm_base_cleared(trim(src) in mdr.sourceTools.set_scoring_FCRA and trim(src) not in mdr.sourceTools.set_scoring_FCRA_retro_test);
			
			base := if(isFCRA, fcra_base, dm_base);

			key_name := if(isFCRA, 
										constants.KeyName_death_master + 'fcra::death_master_ssa::ssn_'+ doxie.Version_SuperKey,
										constants.KeyName_death_master + 'death_master_ssa::ssn_'+ doxie.Version_SuperKey
										);

			return index(base,{ssn},{base},key_name);
			
		end;



 
END;










