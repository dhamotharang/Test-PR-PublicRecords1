import data_services, faa;

// TODO: OPT options should be removed from basefile and index definitions;
//       'temp' should be removed from index names


// Any record definitions can be exported, if needed
export key_override_faa := MODULE

  shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix() + 'thor_data400::key::override::fcra::';
	


  // aircraft registration record
  aircraft_rec := RECORD
    faa.layout_aircraft_registration_out_Persistent_ID;
    string20 flag_file_id;
  end;

  ds_aircraft := dataset (fname_prefix + 'aircraft', aircraft_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_aircraft := dataset (daily_prefix + 'aircraft', aircraft_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_aircraft, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_aircraft,persistent_record_id,replaceds);
  export aircraft := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'aircrafts::qa::ffid', OPT);


  // aircraft detailed info record
  aircraft_detailes_rec := RECORD
    faa.layout_aircraft_info;
    string20 flag_file_id;
  end;

  ds_aircraft_details := dataset (fname_prefix + 'aircraft_details', aircraft_detailes_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_aircraft_details := dataset (daily_prefix + 'aircraft_details', aircraft_detailes_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_aircraft_details, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_aircraft_details,aircraft_mfr_model_code,replaceds);
  export aircraft_details := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'aircraft_details::qa::ffid', OPT);


  // aircraft engine info
  aircraft_engine_rec := RECORD
    faa.layout_engine_info;
    string20 flag_file_id;
  end;

  ds_aircraft_engine := dataset (fname_prefix + 'aircraft_engine', aircraft_engine_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_aircraft_engine := dataset (daily_prefix + 'aircraft_engine', aircraft_engine_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_aircraft_engine, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_aircraft_engine,engine_mfr_model_code,replaceds);
  export aircraft_engine := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'aircraft_engine::qa::ffid', OPT);



// ===========================================================================
// ================== PILOT'S REGISTRATIONS / CERTIFICATES ===================
// ===========================================================================

  shared keyname_prefix_airmen := data_services.data_location.prefix ('fcra_overrides') + 
                          'thor_data400::key::override::fcra::pilot_';

  // main pilot registration
  airmen_rec := RECORD
    faa.layout_airmen_Persistent_ID;
    string20 flag_file_id;
  end;

  ds_airmen := dataset (fname_prefix + 'pilot_registration', airmen_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_airmen := dataset (daily_prefix + 'pilot_registration', airmen_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_airmen, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_airmen,persistent_record_id,replaceds);
  // "using "airmen" breaks the syntax check
  export airmen_reg := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix_airmen + 'registration::qa::ffid', OPT);


  // certification
  cert_rec := RECORD
    faa.layout_airmen_certificate_out;
    string20 flag_file_id;
  end;

  ds_cert := dataset (fname_prefix + 'pilot_certificate', cert_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_cert := dataset (daily_prefix + 'pilot_certificate', cert_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_cert, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_cert,persistent_record_id,replaceds);
  // "using "airmen" breaks the syntax check
  export airmen_cert := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix_airmen + 'certificate::qa::ffid', OPT);

END;
