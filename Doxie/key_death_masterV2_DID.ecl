import header, census_data, did_add, data_services, Death_Master;

//create did key based on the new base file including state_death_id

death_record := record
	Death_Master.File_DeathMaster_Building;
	//string2 src := '';
  //string1 glb_flag := '';	
	string18 county_name := '';
end;

death_ready := table(Death_Master.File_DeathMaster_Building((unsigned6)did != 0), death_record /*and not [state_death_flag, death_rec_src]*/);

//get county name
census_data.MAC_Fips2County(death_ready,state,fipscounty,county_name,dead_with_county);

//distribute, sort by DID
dead_with_county_dist := distribute(dead_with_county, hash(did));
dead_with_county_sort := sort(dead_with_county_dist, did, local);

//build index on DID
export key_death_masterv2_did := index(dead_with_county_sort,
                               {unsigned6 l_did := (integer)did},{dead_with_county_sort},
				           data_services.data_location.prefix('Death')+'thor_data400::key::did_death_masterv2_'+doxie.Version_SuperKey);