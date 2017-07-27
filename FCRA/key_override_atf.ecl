import ATF_Services, data_services, mdr;

EXPORT key_override_atf := module
	shared fname_prefix := data_services.data_location.prefix('ATF') + 'thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix('ATF') + 'thor_data400::key::override::fcra::atf::qa::';

  atf_rec := RECORD
    ATF_Services.layouts.firearms_out;
    string20 flag_file_id;
  end;
	
  ds_atf := dataset (fname_prefix + 'atf', atf_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_atf := dataset (daily_prefix + 'atf', atf_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_atf, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_atf,atf_id,replaceds);
	
  export atf := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'ffid', OPT);

end;