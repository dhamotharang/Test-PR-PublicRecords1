import risk_indicators, dx_Gong, address, data_services;

export GongHistoryFunction(dataset(Risk_Indicators.Layout_Input) bsprep, dataset(risk_indicators.Layout_BocaShell_Neutral) shell,
														string30 account_value, unsigned6 adl_value) := function

	// search for overrides
	search_rec := record
		unsigned4 seq;
		unsigned6 did;
		string9 ssn;
		string30 fname;
		string30 lname;
		string30 mname;
		// flag fields
		string20 flag_file_id;
		string20 file_id;
		string100 record_id;
	end;


	input_from_shell := project(shell, transform(search_rec, self := left, self := [];));
	input_From_user := project(bsprep, transform(search_rec, self.did := adl_value, self := [];));
	input_with_did := if(adl_value<>0, input_From_user, input_from_shell);	// choose to use either customer input adl or appended did if no input adl


	unsigned4 MAX_OVERRIDE_LIMIT := 100;
	layout_overrides := RECORD
		DATASET (fcra.Layout_override_flag) flagrecs {MAXCOUNT(100)};
	END;
	layout_overrides GetFlagRecords (input_with_did le) := TRANSFORM
		ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (keyed (l_ssn = Le.ssn), datalib.NameMatch (Le.fname, Le.mname, Le.lname, fname, mname, lname)<3), MAX_OVERRIDE_LIMIT);
		did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did=(string)Le.did)), MAX_OVERRIDE_LIMIT);
		flags := PROJECT (did_flags, fcra.Layout_override_flag) + PROJECT (ssn_flags, fcra.Layout_override_flag);
		SELF.flagrecs := CHOOSEN (dedup(flags, ALL), MAX_OVERRIDE_LIMIT);
	END;

	ds_flagfile := NORMALIZE(
		PROJECT(input_with_did, GetFlagRecords (Left)),
		LEFT.flagrecs,
		TRANSFORM(fcra.Layout_override_flag, SELF := Right)
	);

	Layout_Gong := dx_Gong.layouts.i_history_did;

	gong_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.GONG), flag_file_id );
	gong_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.GONG), trim(record_id) );
	gong_corr  := CHOOSEN(FCRA.key_override_gong_ffid( keyed( flag_file_id in gong_ffids ) ), MAX_OVERRIDE_LIMIT );

	gong_main := join(input_with_did, dx_Gong.key_history_did(data_services.data_env.iFCRA),
		(unsigned)left.did<>0
			and keyed((unsigned)left.did=right.l_did)
			and trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in gong_keys // old way - prior to 11/13/2012
			and trim((string)right.persistent_record_id) not in gong_keys, // new way - using persistent_record_id
		transform( layout_gong, self := right ),
		KEEP(100), LIMIT(1000)
	);
	gong_deduped := dedup(sort(gong_main,record),all);

	gong_recs := gong_deduped + PROJECT( gong_corr,
			transform( Layout_Gong,
				self.l_did := left.did,
				self := LEFT,
				SELF := [], // flag_file_id, global_sid, record_sid
			) );
	//

	FCRA.GongHistoryLayouts.Layout_GongHistoryFCRA finalize( gong_recs le ) := TRANSFORM
		self.account_number := '';
		self.gong := le;
		self.gong.adl := le.l_did;
		self.gong.address := Address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	END;

	gong_final := project( gong_recs, finalize(left) );

	gong_final2 := dedup(sort(gong_final, -gong.dt_first_seen, -gong.dt_last_seen, gong.phone10, -gong.listing_type_bus, -gong.listing_type_res, -gong.listing_type_gov),
		gong.dt_first_seen, gong.dt_last_seen, gong.phone10);

	return gong_final2;
end;
