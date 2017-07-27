import header, census_data, did_add;

death_record := record
	header.File_Did_Death_Master;
	string18 county_name := '';
end;

death_ready := table(header.File_Did_Death_Master, death_record);

census_data.MAC_Fips2County(death_ready,state,fipscounty,county_name,dead_with_county);

export key_death_master_did := index(dead_with_county(did<>'000000000000'),
                               {unsigned6 l_did := (integer)did},{dead_with_county},
				           '~thor_data400::key::did_death_master' + thorlib.WUID());