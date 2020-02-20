import header, census_data, did_add, data_services, death_master,mdr;

//create did key based on the new base file including state_death_id

death_record := record
	//CCPA-17 This key is not used by any query, thus no CCPA field is needed.
	RECORDOF(Death_Master.File_DeathMaster_Building) - [global_sid, record_sid];
	string18 county_name := '';

end;

//Remove TS and EN src from FCRA keys
// death_ready := table(Death_Master.File_DeathMaster_Building((unsigned6)did != 0  and glb_flag != 'Y' and (src in mdr.sourceTools.set_scoring_FCRA) and (src not in mdr.sourceTools.set_scoring_FCRA_retro_test)), death_record /*and not [state_death_flag, death_rec_src]*/);
//get county name
// census_data.MAC_Fips2County(death_ready,state,fipscounty,county_name,dead_with_county);

//distribute, sort by DID
// dead_with_county_dist := distribute(dead_with_county, hash(did));
dead_with_county_sort := dataset([],death_record);

//build index on DID
export key_death_masterv2_did_fcra := index(dead_with_county_sort,
                               {unsigned6 l_did := (integer)did},{dead_with_county_sort},
				           data_services.data_location.prefix('Death')+'thor_data400::key::fcra::did_death_masterv2_'+doxie.Version_SuperKey);