import watercraft, ut, data_services;

export key_override_watercraft := MODULE

  shared fname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::watercraft::qa::';

  // SID
  export sid_rec := record
	  string20 flag_file_id;
    recordof (watercraft.key_watercraft_sid (true));
  end;

  ds_sid := dataset (fname_prefix + 'watercraft', sid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_sid := dataset (daily_prefix + 'watercraft', sid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  //TODO: why dedup? shouldn't it be done in the input dataset?
  kf := dedup (sort (ds_sid, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_sid,persistent_record_id,replaceds);	
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::watercraft::qa::watercraft_sid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, Watercraft.Constants.fields_to_clear_sid);
  export sid := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'watercraft_sid');

  // CID (coast guard)
  cid_rec := record
	  string20 flag_file_id;
    recordof (watercraft.key_watercraft_cid (true));
  end;

  ds_cguard := dataset (fname_prefix + 'watercraft_cguard', cid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_cguard := dataset (daily_prefix + 'watercraft_cguard', cid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_cguard, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_cguard,persistent_record_id,replaceds);
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::watercraft::qa::watercraft_cid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, Watercraft.Constants.fields_to_clear_cid);
  export cid := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'watercraft_cid');


  wid_rec := record
	  string20 flag_file_id;
    recordof (watercraft.key_watercraft_wid (true));
  end;

  ds_wid := dataset (fname_prefix + 'watercraft_details', wid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_wid := dataset (daily_prefix + 'watercraft_details', wid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_wid, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_wid,persistent_record_id,replaceds);
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::watercraft::qa::watercraft_wid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, Watercraft.Constants.fields_to_clear_wid);
  export wid := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'watercraft_wid');

END;