import doxie, fcra, riskwise, ut;

EXPORT _Death_data(	dataset (doxie.layout_references) dids, 
                      dataset (fcra.Layout_override_flag) flag_file
) := function
	

	main_ffids := SET (flag_file (file_id = FCRA.FILE_ID.DID_death), flag_file_id);
  main_rids  := SET (flag_file (file_id = FCRA.FILE_ID.DID_death), record_id);

  // MAIN data
  key_main := doxie.key_death_masterV2_ssa_DID_fcra;
  rec_main := recordof (key_main)- [global_sid, record_sid];
  
  raw_data := join (dids, key_main,
		left.did<>0 and
    keyed (left.did = right.l_did) and
		trim(right.did) + trim(right.state_death_id) not in main_rids,
    transform (rec_main, Self := Right),
    atmost(riskwise.max_atmost)
  );

  // overrides
  override_records := choosen(FCRA.key_override_death_master.did_death(keyed(flag_file_id in main_ffids)), FCRA.compliance.max_override_limit);

  all_together := raw_data + project (override_records, transform (rec_main, Self := Left));
	
	final := sort(all_together, -dod8, -filedate, death_rec_src, -state_death_id);
	

	// OUTPUT(FLAG_FILE, NAMED('FLAG_FILE'));
	// output(raw_data, named('raw_data'));
	
  return final;

END;