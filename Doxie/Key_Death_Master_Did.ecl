Import Data_Services, header, census_data, did_add, UT;

death_record := record
	header.File_Did_Death_Master;
	string18 county_name := '';
end;

death_ready := table(header.File_Did_Death_Master, death_record /*and not [state_death_flag, death_rec_src]*/);

census_data.MAC_Fips2County(death_ready,state,fipscounty,county_name,dead_with_county);

export key_death_master_did := index(dead_with_county(did<>'000000000000'),
                               {unsigned6 l_did := (integer)did},{dead_with_county},
				           Data_Services.Data_location.prefix('Death')+'thor_data400::key::did_death_master_'+doxie.Version_SuperKey);