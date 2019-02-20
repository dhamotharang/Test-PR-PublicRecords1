IMPORT Data_Services, sexoffender, ut;

EXPORT key_override_sexoffender := module
	shared fname_prefix := data_services.data_location.prefix('fcra_overrides') + 'thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix('fcra_overrides') + 'thor_data400::key::override::fcra::';
	
  export SOff_rec := RECORD
		string20 flag_file_id;
		recordof(SexOffender.key_SexOffender_SPK());
  end;

  ds_SOff := dataset (fname_prefix + 'so_main', SOff_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_SOff := dataset (daily_prefix + 'so_main', SOff_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf_SOff := dedup (sort (ds_SOff, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf_soff,dailyds_soff,seisint_primary_key,replaceds);
	// DF-22458 Blank out specified fields in thor_data400::key::override::fcra::so_main::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, SexOffender.Constants.fields_to_clear_spkpublic);
  export so_main := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'so_main::qa::ffid', OPT);
		
	//TODO: this should be in a defined layout...
	offense_rec := record
		string20 flag_file_id;
		recordof(SexOffender.Key_SexOffender_offenses());
	end;
	
	ds_offenses := dataset (fname_prefix + 'so_offenses', offense_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_offenses := dataset (daily_prefix + 'so_offenses', offense_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf_offenses := dedup (sort (ds_offenses, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf_offenses,dailyds_offenses,seisint_primary_key,replaceds);
	// DF-22458 Blank out specified fields in thor_data400::key::override::fcra::so_offenses::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, SexOffender.Constants.fields_to_clear_offenses_public);
  export so_offenses := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'so_offenses::qa::ffid', OPT);
end;