IMPORT Phones, STD, UT;

EXPORT PhoneAttributes_BatchRecords(
	DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dBatchPhonesIn,
	Phones.IParam.PhoneAttributes.BatchParams in_mod)
	:= FUNCTION

	Consts := Phones.Constants.PhoneAttributes;
	Layout_BatchOut := Phones.Layouts.PhoneAttributes.BatchOut;
	Layout_BatchRaw	:= Phones.Layouts.PhoneAttributes.Raw;

	dPortedPhoneswLineType := Phones.GetPhoneMetadata_wLIDB(dBatchPhonesIn,in_mod);

	//prioritize Realtime LIDB
	dPortedPhonesSorted := SORT(dPortedPhoneswLineType, acctno,phone, -dt_last_reported, -dt_first_reported,
		source <> Consts.ATT_LIDB_RealTime, record);
	Layout_BatchOut tOutputLayout(Layout_BatchRaw L) := TRANSFORM
		SELF.acctno := L.acctno;
		SELF.phoneno := L.phone;
		SELF.is_current	:= FALSE;	//Value assigned in iteration

		// * Disconnect event_date = deact_start_dt
		// * Ported phone event_date = port_start_dt
		// * Swap Phone Number event_date = swap_start_dt
		// * Suspended Number event_date = deact_start_dt
		// * Reactivated Number event_date = react_start_dt
		boolean ported_phone := L.source = Consts.ICONECTIV_SRC;
		boolean ported_line := ported_phone or  L.source IN Consts.set_ATT_LIDB;

		//identifies both historic and current disconnect records
		boolean disconnected := L.deact_code = Consts.DISCONNECTED_CODE and (L.is_deact = 'Y' OR L.is_deact = 'N');
		boolean number_swapped := L.phone_swap <> '';
		boolean suspended := L.deact_code = Consts.SUSPENDED_CODE and in_mod.include_temp_susp_reactivate;
		boolean reactivated := L.deact_code = Consts.SUSPENDED_CODE and L.is_react = 'Y';
		boolean lidb_verfication := L.source IN Consts.set_ATT_LIDB;
		event_type := if(ported_phone, Consts.PORTED_PHONE, '') +
			if(disconnected and not ported_phone, Consts.DISCONNECTED, '') +
			if(reactivated, Consts.REACTIVATED, '') +
			if(number_swapped, Consts.NUMBER_SWAPPED, '') +
			if(suspended, Consts.SUSPENDED, '') +
			if(lidb_verfication, Consts.LIDB_VERFICATION, '');

		event_date := if(lidb_verfication,L.dt_last_reported,MAX(L.port_start_dt, L.swap_start_dt, L.deact_start_dt, L.react_start_dt));
		SELF.event_type := event_type;
		SELF.event_date	:= if(event_type <> '', event_date, 0);

		// populate disconnect date based on record's event type to report most recent event date
		SELF.disconnect_date := MAP(disconnected => L.deact_start_dt,
			number_swapped => L.swap_start_dt, 0);

		SELF.ported_date := if(ported_phone, L.port_start_dt, 0);
		SELF.carrier_id	:= L.account_owner;
		SELF.carrier_name := L.carrier_name;
		SELF.carrier_category := L.carrier_category;
		SELF.operator_id := L.spid;
		SELF.operator_name := if(L.operator_fullname <> '', L.operator_fullname, L.carrier_name);
		SELF.line_type_last_seen := CASE(L.source,
			Consts.ATT_LIDB_SRC => L.dt_last_reported,
			Consts.ATT_LIDB_RealTime => L.dt_last_reported,
			Consts.ICONECTIV_SRC => L.port_start_dt, 0);

		SELF.phone_serv_type := if(ported_line, L.serv, '');
		SELF.phone_line_type := if(ported_line, L.line, '');
		SELF.swapped_phone_number_date := if(number_swapped, L.swap_start_dt, 0);
		SELF.new_phone_number_from_swap	:= L.phone_swap;
		SELF.suspended_date := if(suspended, L.deact_start_dt, 0);
		SELF.reactivated_date := if(reactivated, L.react_start_dt, 0);
		SELF.source := L.source;
		SELF.prepaid := L.prepaid;
		SELF.error_desc	:= L.error_desc;
		SELF.carrier_city := L.carrier_city;
		SELF.carrier_state := L.carrier_state;

		//Check if the current record is outdated, from PX, or has an error_code, if so we mark dialable false.
		today := STD.Date.Today();
		earliestAllowedDate := (UNSIGNED)ut.date_math((STRING)today, -in_mod.max_lidb_age_days);
		boolean is_outdated := SELF.event_date < earliestAllowedDate;
		SELF.dialable := ~is_outdated AND L.error_desc = '' AND L.source <> Consts.DISCONNECT_SRC;

		//These values are assigned below when all the most recent data is combined so they match what is being displayed.
		SELF.phone_line_type_desc := '';
		SELF.phone_serv_type_desc := '';
	END;
	dIntermediateBatchPhones := PROJECT(dPortedPhonesSorted, tOutputLayout(LEFT));

	dFilterBatchPhones	:= if(in_mod.include_temp_susp_reactivate,
		dIntermediateBatchPhones,
		dIntermediateBatchPhones(event_type NOT IN [Consts.SUSPENDED, Consts.REACTIVATED, Consts.REACTIVATED+Consts.SUSPENDED]));

	//Check previous records to mark PORTED_LINE events
	//A PORTED_PHONE event becomes a PORTED_PHONE+PORTED_LINE event when the most recent historic record
	//has either serv or line populated with a value different from the current record OR
	//if no historic record exists with line or serv
	dPortedLineSortPhones := SORT(dFilterBatchPhones, acctno, phoneno, -event_date);

	Layout_BatchOut tMostRecentRecord(Layout_BatchOut L) := TRANSFORM
		allrows_rec := dPortedLineSortPhones(acctno = L.acctno and phoneno = L.phoneno and event_date < L.event_date);
		SELF.disconnect_date :=	MAX(L.disconnect_date, MAX(allrows_rec, allrows_rec.disconnect_date)
			,MAX(allrows_rec,allrows_rec.swapped_phone_number_date)); // swaps also produces a disconnected phone
		SELF.ported_date :=	MAX(L.ported_date, MAX(allrows_rec, allrows_rec.ported_date));
		SELF.line_type_last_seen :=	MAX(L.line_type_last_seen, MAX(allrows_rec, allrows_rec.line_type_last_seen));
		SELF.phone_serv_type :=	MAX(L.phone_serv_type, MAX(allrows_rec, allrows_rec.phone_serv_type));
		SELF.phone_line_type :=	MAX(L.phone_line_type, MAX(allrows_rec, allrows_rec.phone_line_type));
		SELF.swapped_phone_number_date := MAX(L.swapped_phone_number_date, MAX(allrows_rec, allrows_rec.swapped_phone_number_date));
		SELF.new_phone_number_from_swap	:= MAX(L.new_phone_number_from_swap, MAX(allrows_rec, allrows_rec.new_phone_number_from_swap));
		SELF.suspended_date	:= MAX(L.suspended_date, MAX(allrows_rec, allrows_rec.suspended_date));
		SELF.reactivated_date := MAX(L.reactivated_date, MAX(allrows_rec, allrows_rec.reactivated_date));
		SELF.phone_line_type_desc := IF(SELF.phone_line_type = '', '', Phones.Functions.LineServiceTypeDesc((INTEGER)SELF.phone_line_type));
		SELF.phone_serv_type_desc := IF(SELF.phone_serv_type = '', '', Phones.Functions.LineServiceTypeDesc((INTEGER)SELF.phone_serv_type));
		SELF := 	L;
	END;

	dPhonesMostRecentRecord := PROJECT(dPortedLineSortPhones,tMostRecentRecord(LEFT));

	Layout_BatchOut tMarkPortedLines(dPhonesMostRecentRecord L, dPhonesMostRecentRecord R, INTEGER C) := TRANSFORM
		boolean is_same_account := L.acctno = R.acctno and L.phoneno = R.phoneno;
		boolean is_ported_event	:= R.event_type = Consts.PORTED_PHONE;
		boolean exists_hist_line:= L.phone_line_type <> '';
		boolean exists_hist_serv:= L.phone_serv_type <> '';
		boolean is_line_match := L.phone_line_type = R.phone_line_type;
		boolean is_serv_match := L.phone_serv_type = R.phone_serv_type;
		boolean is_line_ported := is_same_account and is_ported_event and ((~is_line_match or ~is_serv_match) or (~exists_hist_line and ~exists_hist_serv));
		SELF.event_type := MAP( R.source IN Consts.set_ATT_LIDB and is_line_match => Consts.LIDB_VERFICATION,
			R.source IN Consts.set_ATT_LIDB and ~is_line_match and C <> 1 => Consts.PORTED_LINE,
			is_line_ported => TRIM(R.event_type) + Consts.PORTED_LINE,
			R.event_type);
		SELF := R;
	END;
	dPhonesWithEventType := ITERATE(SORT(dPhonesMostRecentRecord, acctno, phoneno, event_date), tMarkPortedLines(LEFT, RIGHT, COUNTER));

	//Now let's mark the most current record as such
	dSortedPhonesEventDate := SORT(dPhonesWithEventType, acctno, phoneno, -event_date);
	Layout_BatchOut tMarkCurrentRecords(Layout_BatchOut L, Layout_BatchOut R) := TRANSFORM
		boolean is_same_account := L.acctno = R.acctno and L.phoneno = R.phoneno;
		SELF.is_current 				:= ~is_same_account;
		SELF										:= R;
	END;
	dPhonesWithCurrent := ITERATE(dSortedPhonesEventDate, tMarkCurrentRecords(LEFT, RIGHT))(is_current or event_type <> '');

	//Some rare cases where we have the same phoneno and event_date, but event_type is C in one and CL in the other
	//I doubt we would have any other event_type cases with the same phoneno and event_date
	Layout_BatchOut tRollRecords(Layout_BatchOut L, Layout_BatchOut R) := TRANSFORM
		SELF.event_type := STD.STR.combineWords(set(
			dedup(sort(ut.WordTokenizer(L.event_type+R.event_type)(char<>''),char),char),char), '');
		SELF := L;
	END;

	dRolledUpPhones := ROLLUP(SORT(dPhonesWithCurrent, acctno, phoneno, -event_date),
		LEFT.acctno = RIGHT.acctno AND
		LEFT.phoneno = RIGHT.phoneno AND
		LEFT.event_date = RIGHT.event_date,
		tRollRecords(LEFT, RIGHT));

	dBatchPhonesOut := if(in_mod.return_current, dRolledUpPhones(is_current), dRolledUpPhones);
	#IF(Phones.Constants.Debug.PhoneAttributes_Main)
		output(dPortedPhonesSorted, named('dPortedPhonesSorted'));
		output(dIntermediateBatchPhones, named('dIntermediateBatchPhones'));
		output(dFilterBatchPhones, named('dFilterBatchPhones'));
		output(dPortedLineSortPhones, named('dPortedLineSortPhones'));
		output(dPhonesMostRecentRecord, named('dPhonesMostRecentRecord'));
		output(dPhonesWithEventType, named('dPhonesWithEventType'));
		output(dSortedPhonesEventDate, named('dSortedPhonesEventDate'));
		output(dPhonesWithCurrent, named('dPhonesWithCurrent'));
		output(dRolledUpPhones, named('dRolledUpPhones'));
	#END

	RETURN dBatchPhonesOut;

END;