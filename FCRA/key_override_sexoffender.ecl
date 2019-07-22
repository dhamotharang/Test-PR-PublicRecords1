IMPORT Data_Services, sexoffender;

EXPORT key_override_sexoffender := module
	shared fname_prefix := data_services.data_location.prefix('fcra_overrides') + 'thor_data400::base::override::fcra::qa::';
  shared keyname_prefix := data_services.data_location.prefix('fcra_overrides') + 'thor_data400::key::override::fcra::';
	
  SOff_rec := RECORD
		string20 flag_file_id;
		recordof(SexOffender.key_SexOffender_SPK());
  end;

  ds_SOff := dataset (fname_prefix + 'so_main', SOff_rec, flat, OPT);
  kf_SOff := dedup (sort (ds_SOff, -flag_file_id), except flag_file_id);
  export so_main := index (kf_SOff, {flag_file_id}, {kf_SOff}, keyname_prefix + 'so_main::qa::ffid', OPT);
		
	//TODO: this should be in a defined layout...
	offense_rec := record
		string20 flag_file_id;
		recordof(SexOffender.Key_SexOffender_offenses());
	end;
	
	ds_offenses := dataset (fname_prefix + 'so_offenses', offense_rec, flat,OPT);
  kf_offenses := dedup (sort (ds_offenses, -flag_file_id), except flag_file_id);
  export so_offenses := index (kf_offenses, {flag_file_id}, {kf_offenses}, keyname_prefix + 'so_offenses::qa::ffid', OPT);
end;