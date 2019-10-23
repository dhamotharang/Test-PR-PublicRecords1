import Death_Master, Doxie,Data_Services, ut;
EXPORT key_override_death_master := module
	shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
	shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::';

//Death Master DID
	export Death_rec := RECORD
	recordof (doxie.key_death_masterV2_DID_fcra);
	string20 flag_file_id;
  END;

	ds_did_death := dataset(fname_prefix + 'did_death',Death_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_did_death := dataset(daily_prefix + 'did_death',Death_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	kf := dedup(sort(ds_did_death,-flag_file_id),except flag_file_id,keep(1));
	FCRA.Mac_Replace_Records(kf,dailyds_did_death,state_death_id,replaceds);

	//DF-21696 blank out specified fields in thor_data400::key::override::fcra::did_death::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, Death_Master.Constants('').fields_to_clear);

	export did_death := index(replaceds_cleared,{flag_file_id}, {replaceds_cleared},
						keyname_prefix + 'did_death::qa::ffid',OPT);

end;