import header, census_data, did_add, data_services, death_master,mdr, vault, _control;

//create did key based on the new base file including state_death_id

death_record := record
	Death_Master.File_DeathMaster_Building_ssa;
	string18 county_name := '';

end;

//Remove TS and EN src from FCRA keys
death_ready := table(Death_Master.File_DeathMaster_Building_ssa((unsigned6)did != 0  and glb_flag != 'Y' and (src in mdr.sourceTools.set_scoring_FCRA) and (src not in mdr.sourceTools.set_scoring_FCRA_retro_test)), death_record /*and not [state_death_flag, death_rec_src]*/);
//get county name
census_data.MAC_Fips2County(death_ready,state,fipscounty,county_name,dead_with_county);

//distribute, sort by DID
dead_with_county_dist := distribute(dead_with_county, hash(did));
dead_with_county_sort := sort(dead_with_county_dist, did, local);


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_death_masterv2_ssa_did_fcra := vault.doxie.key_death_masterV2_ssa_DID_fcra;
#ELSE
//build index on DID
export key_death_masterv2_ssa_did_fcra := index(dead_with_county_sort,
                               {unsigned6 l_did := (integer)did},{dead_with_county_sort},
				           data_services.data_location.prefix('Death')+'thor_data400::key::fcra::did_death_masterv2_ssa_'+doxie.Version_SuperKey);
#END;

