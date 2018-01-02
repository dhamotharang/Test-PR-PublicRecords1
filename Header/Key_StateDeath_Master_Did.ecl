import header, census_data, did_add, data_services;

death_record := record
	header.File_Did_StateDeath_Master;
	string18 county_name := '';
end;

death_ready := table(header.File_Did_StateDeath_Master, death_record);

census_data.MAC_Fips2County(death_ready, state, fips_county, county_name, dead_with_county);

export key_statedeath_master_did := index(dead_with_county(did <> '000000000000'),
                                          {unsigned6 l_did := (integer)did}, {dead_with_county},
				                                  data_services.data_location.prefix() + 'thor_data400::key::did_statedeath_master' + thorlib.WUID());