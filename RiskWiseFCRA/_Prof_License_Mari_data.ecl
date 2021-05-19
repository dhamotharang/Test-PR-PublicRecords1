import data_services, doxie, fcra, dx_prof_license_mari, riskwise;

EXPORT _Prof_License_Mari_data(	dataset (doxie.layout_references) dids, 
																dataset (fcra.Layout_override_flag) flag_file
) := function

  main_ffids := SET (flag_file (file_id = FCRA.FILE_ID.MARI), flag_file_id);
  main_rids  := SET (flag_file (file_id = FCRA.FILE_ID.MARI), record_id);

  // MAIN data
  key_main := dx_prof_license_mari.key_did(data_services.data_env.iFCRA);
  rec_main := recordof (key_main);
  
  raw_data := join (dids, key_main,
		left.did<>0 and
    keyed (left.did = right.s_did)
    and ((string)right.persistent_record_id not in main_rids),
    transform (rec_main, Self := Right),
    atmost(riskwise.max_atmost)
  );

  // overrides
  override_records := choosen (FCRA.Key_Override_Proflic_Mari_ffid.proflic_mari(keyed (flag_file_id in main_ffids)), FCRA.compliance.max_override_limit);
  all_together := raw_data + project (override_records, transform (rec_main, self.s_did := (unsigned)left.did, Self := Left, self := []));
  
	final := sort(all_together, -date_first_seen, -date_last_seen, -persistent_record_id);
	
  return final;

END;
