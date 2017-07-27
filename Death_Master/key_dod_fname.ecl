import header, census_data, did_add, doxie;

//payload changed to the new basefile including state_death_id
death_record := record
	header.File_Did_Death_MasterV2;
	string18 county_name := '';
end;

death_ready := table(header.File_Did_Death_MasterV2, death_record);

//get county name
census_data.MAC_Fips2County(death_ready,state,fipscounty,county_name,dead_with_county);

//filter out blank fname and dod, distribute and sort by them

dead_with_county_dist := distribute(dead_with_county(fname <> '' and dod8<> ''), hash(fname, dod8));
dead_with_county_sort := sort(dead_with_county_dist, fname, dod8, local);

//build index on fname and dod8 
export key_dod_fname := index(dead_with_county_sort,
                               {fname, dod8},{dead_with_county_sort},
				           '~thor_data400::key::dod_fname_death_masterV2_'+ doxie.Version_SuperKey);





