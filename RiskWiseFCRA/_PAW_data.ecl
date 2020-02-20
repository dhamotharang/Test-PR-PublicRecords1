IMPORT doxie, fcra, paw, ut, riskwise, Std;

EXPORT _PAW_data(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file, unsigned1 year_limit = 0) := FUNCTION

	Layout_PAW := recordof(paw.Key_DID_FCRA) - [global_sid, record_sid];

	paw_ffids := SET(flag_file(file_id = FCRA.FILE_ID.paw), flag_file_id );
	paw_correction_keys  := SET(flag_file(file_id = FCRA.FILE_ID.paw), trim(record_id) );
	paw_corr  := CHOOSEN(FCRA.key_override_paw_ffid( keyed( flag_file_id in paw_ffids ) ), FCRA.compliance.MAX_OVERRIDE_LIMIT );

	paw_main  := join(dids, paw.Key_DID_FCRA,
													left.did<>0 and keyed(left.did=right.did)
													and (string)right.contact_id not in paw_correction_keys,
													transform(Layout_PAW, self := right),
													KEEP(100), atmost(riskwise.max_atmost));
													
	paw_deduped := dedup(sort(paw_main,record),all);  // dedup all just in case the data has any dups

	paw_recs1 := paw_deduped + PROJECT( paw_corr, transform( Layout_PAW, self := LEFT) );	
		
	todaysdate := (STRING8)Std.Date.Today();
	//if called from benefitassessment_batchservicefcra, we get records from the last 12 months ~ 1 year
	paw_recs_filtered := paw_recs1(ut.fn_date_is_ok(todaysdate, dt_last_seen , year_limit));

	paw_recs2 := if(year_limit=0, paw_recs1, paw_recs_filtered);

	paw_recs := sort(paw_recs2, -dt_last_seen, -dt_first_seen);
	
	// output(flag_file,named('flag_file'));
	// ff_paw := flag_file(file_id = FCRA.FILE_ID.paw);
	// output(ff_paw,named('ff_paww'));
	// output(paw_corr,named('paww_corr'));
	// output(paw_main,named('paww_main'));
	// output(paw_deduped,named('paww_deduped'));
	// output(paw_recs1,named('paww_recs1'));
	// output(paw_recs_filtered,named('paw_recs_filtered'));
	// output(paw_recs2,named('paww_recs2'));
	// output(paw_recs,named('paww_recs'));
		
	return paw_recs;
END;