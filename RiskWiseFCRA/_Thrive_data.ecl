import doxie, fcra, thrive, riskwise, ut, mdr;

EXPORT _Thrive_data(	dataset (doxie.layout_references) dids, 
                      dataset (fcra.Layout_override_flag) flag_file
) := function
	
	main_ffids := SET (flag_file (file_id = FCRA.FILE_ID.THRIVE), flag_file_id);
  main_rids  := SET (flag_file (file_id = FCRA.FILE_ID.THRIVE), record_id);

  // MAIN data
  key_main := thrive.keys().did_fcra.qa;
  rec_main := recordof (key_main);
  
  raw_data := join (dids, key_main,
		left.did<>0 and
    keyed (left.did = right.did)
    and ((string)right.persistent_record_id not in main_rids)
		and right.src = mdr.sourceTools.src_Thrive_PD
		and (ut.daysapart((string)right.dt_first_seen, ut.GetDate) < ut.DaysInNYears(7)),
    transform (rec_main, Self := Right),
    atmost(riskwise.max_atmost)
  );

  // overrides
  override_records := choosen(FCRA.Key_Override_Thrive_ffid.thrive(keyed(flag_file_id in main_ffids)), FCRA.compliance.max_override_limit);

  all_together := raw_data + project (override_records, transform (rec_main, SELF.global_sid:= 0, SELF.record_sid:= 0,Self := Left));
  	  
	final := sort(all_together, -dt_first_seen, -dt_last_seen, src, -persistent_record_id);
  return final;

END;