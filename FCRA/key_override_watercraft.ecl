import watercraft, data_services;

export key_override_watercraft := MODULE

  shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix()+'thor_data400::key::override::fcra::watercraft::qa::';

  // SID
  sid_rec := record
	  string20 flag_file_id;
		 //CCPA-206 exclude CCPA fields in override keys for now
    recordof (watercraft.key_watercraft_sid (true)) - [global_sid,record_sid];
  end;

  ds_sid := dataset (fname_prefix + 'watercraft', sid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_sid := dataset (daily_prefix + 'watercraft', sid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  //TODO: why dedup? shouldn't it be done in the input dataset?
  kf := dedup (sort (ds_sid, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_sid,persistent_record_id,replaceds);
  export sid := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'watercraft_sid');

  // CID (coast guard)
  cid_rec := record
	  string20 flag_file_id;
		 //CCPA-206 exclude CCPA fields in override keys for now
    recordof (watercraft.key_watercraft_cid (true))- [global_sid,record_sid];
  end;

  ds_cguard := dataset (fname_prefix + 'watercraft_cguard', cid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_cguard := dataset (daily_prefix + 'watercraft_cguard', cid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_cguard, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_cguard,persistent_record_id,replaceds);
  export cid := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'watercraft_cid');


  wid_rec := record
	  string20 flag_file_id;
		 //CCPA-206 exclude CCPA fields in override keys for now
    recordof (watercraft.key_watercraft_wid (true)) - [global_sid,record_sid];
  end;

  ds_wid := dataset (fname_prefix + 'watercraft_details', wid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_wid := dataset (daily_prefix + 'watercraft_details', wid_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_wid, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_wid,persistent_record_id,replaceds);
  export wid := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'watercraft_wid');

END;