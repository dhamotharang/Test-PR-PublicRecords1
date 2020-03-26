import data_services, faa, ut;

// TODO: OPT options should be removed from basefile and index definitions;
//       'temp' should be removed from index names


// Any record definitions can be exported, if needed
export key_override_faa := MODULE

  shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := '~thor_data400::key::override::fcra::';
	


  // aircraft registration record
  export aircraft_rec := RECORD
    faa.layout_aircraft_registration_out_Persistent_ID;
    string20 flag_file_id;
  end;

  ds_aircraft := dataset (fname_prefix + 'aircraft', aircraft_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_aircraft := dataset (daily_prefix + 'aircraft', aircraft_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_aircraft, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_aircraft,persistent_record_id,replaceds);
	//DF-22458 Clear speicifed fields in thor_data400::key::override::fcra::aircrafts::qa::ffid 
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, faa.Constants.fields_to_clear_aircraft);
  export aircraft := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'aircrafts::qa::ffid', OPT);


  // aircraft detailed info record
  aircraft_detailes_rec := RECORD
    faa.layout_aircraft_info;
    string20 flag_file_id;
  end;

  ds_aircraft_details := dataset (fname_prefix + 'aircraft_details', aircraft_detailes_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_aircraft_details := dataset (daily_prefix + 'aircraft_details', aircraft_detailes_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_aircraft_details, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_aircraft_details,aircraft_mfr_model_code,replaceds);
	//DF-22458 Clear specified fields in thor_data400::key::override::fcra::aircraft_details::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, faa.Constants.fields_to_clear_aircraft_details);
  export aircraft_details := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'aircraft_details::qa::ffid', OPT);


  // aircraft engine info
  aircraft_engine_rec := RECORD
    faa.layout_engine_info;
    string20 flag_file_id;
  end;

  ds_aircraft_engine := dataset (fname_prefix + 'aircraft_engine', aircraft_engine_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_aircraft_engine := dataset (daily_prefix + 'aircraft_engine', aircraft_engine_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_aircraft_engine, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_aircraft_engine,engine_mfr_model_code,replaceds);
	// DF-22458 Blank out specified fields in thor_data400::key::override::fcra::aircraft_engine::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, faa.Constants.fields_to_clear_aircraft_engine);
  export aircraft_engine := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'aircraft_engine::qa::ffid', OPT);



// ===========================================================================
// ================== PILOT'S REGISTRATIONS / CERTIFICATES ===================
// ===========================================================================

  shared keyname_prefix_airmen := data_services.data_location.prefix ('fcra_overrides') + 
                          'thor_data400::key::override::fcra::pilot_';

  // main pilot registration
  export airmen_rec := RECORD
    faa.layout_airmen_Persistent_ID;
    string20 flag_file_id;
  end;

  ds_airmen := dataset (fname_prefix + 'pilot_registration', airmen_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_airmen := dataset (daily_prefix + 'pilot_registration', airmen_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_airmen, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_airmen,persistent_record_id,replaceds);
	//DF-22458 Clear specified fields in thor_data400::key::override::fcra::pilot_registration::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, faa.Constants.fields_to_clear_pilot_registration);
  // "using "airmen" breaks the syntax check
  export airmen_reg := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix_airmen + 'registration::qa::ffid', OPT);


  // certification
  cert_rec := RECORD
    faa.layout_airmen_certificate_out;
    string20 flag_file_id;
  end;

  ds_cert := dataset (fname_prefix + 'pilot_certificate', cert_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_cert := dataset (daily_prefix + 'pilot_certificate', cert_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_cert, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_cert,persistent_record_id,replaceds);
	//DF-22458 Clear specified fields in thor_data400::key::override::fcra::pilot_certificate::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, faa.Constants.fields_to_clear_pilot_certificate);
  // "using "airmen" breaks the syntax check
  export airmen_cert := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix_airmen + 'certificate::qa::ffid', OPT);

END;
