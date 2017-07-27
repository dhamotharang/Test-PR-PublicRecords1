import header, death_master, census_data, did_add, doxie, data_services;

//state_death_id key is based on new death master base file
death_record := record
	Death_Master.File_DeathMaster_Building;
	string18 county_name := '';

end;

death_ready := table(Death_Master.File_DeathMaster_Building, death_record /*and not [state_death_flag, death_rec_src]*/);

//get county name

census_data.MAC_Fips2County(death_ready,state,fipscounty,county_name,dead_with_county);

//distribute and sort by state_death_id
dead_with_county_dist := distribute(dead_with_county, hash(state_death_id));
dead_with_county_sort := sort(dead_with_county_dist, state_death_id, local);

//build index on state_death_id
export key_death_id_base := index(dead_with_county_sort,
                               {state_death_id},{dead_with_county_sort},
				           data_services.data_location.prefix('Death')+'thor_data400::key::death_id_death_masterV2_'+doxie.Version_SuperKey);

