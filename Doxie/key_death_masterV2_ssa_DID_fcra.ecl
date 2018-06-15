import header, census_data, did_add, data_services, death_master,mdr,ut;

//create did key based on the new base file including state_death_id

death_record := record
	Death_Master.File_DeathMaster_Building_ssa;
	string18 county_name := '';

end;

//Remove TS and EN src from FCRA keys
death_ready := table(Death_Master.File_DeathMaster_Building_ssa((unsigned6)did != 0  and (src in mdr.sourceTools.set_scoring_FCRA) and (src not in mdr.sourceTools.set_scoring_FCRA_retro_test)), death_record /*and not [state_death_flag, death_rec_src]*/);
//get county name
census_data.MAC_Fips2County(death_ready,state,fipscounty,county_name,dead_with_county);

//distribute, sort by DID
dead_with_county_dist := distribute(dead_with_county, hash(did));
dead_with_county_sort := sort(dead_with_county_dist, did, local);

//DF-21696 blank out specified fields in thor_data400::key::fcra::did_death_masterv2_ssa_qa
ut.MAC_CLEAR_FIELDS(dead_with_county_sort, dead_with_county_sort_cleared, Death_Master.Constants('').fields_to_clear);

//build index on DID
export key_death_masterv2_ssa_did_fcra := index(dead_with_county_sort_cleared,
                               {unsigned6 l_did := (integer)did},{dead_with_county_sort_cleared},
				           data_services.data_location.prefix('Death')+'thor_data400::key::fcra::did_death_masterv2_ssa_'+doxie.Version_SuperKey);