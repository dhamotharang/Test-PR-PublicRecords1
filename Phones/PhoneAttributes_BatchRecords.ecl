IMPORT Phones, STD, UT;

EXPORT PhoneAttributes_BatchRecords(
	DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dBatchPhonesIn,
	Phones.IParam.PhoneAttributes.BatchParams in_mod)
	:= FUNCTION

	Consts := Phones.Constants.PhoneAttributes;
	Layout_BatchOut := Phones.Layouts.PhoneAttributes.BatchOut;
	Layout_BatchRaw	:= Phones.Layouts.PhoneAttributes.Raw;

 	dIntermediateBatchPhones := Phones.GetPhoneMetadata_wLIDB(dBatchPhonesIn,in_mod);
   
  dFilterBatchPhones	:= if(in_mod.include_temp_susp_reactivate,
  dIntermediateBatchPhones,
  dIntermediateBatchPhones(event_type NOT IN [Consts.SUSPENDED, Consts.REACTIVATED, Consts.REACTIVATED+Consts.SUSPENDED]));

	//Check previous records to mark PORTED_LINE events
	//A PORTED_PHONE event becomes a PORTED_PHONE+PORTED_LINE event when the most recent historic record
	//has either serv or line populated with a value different from the current record OR
	//if no historic record exists with line or serv
	
	dPortedLineSortPhones := SORT(dFilterBatchPhones, acctno, phoneno, -event_date);

	Layout_BatchOut tMostRecentRecord(Layout_BatchRaw L) := TRANSFORM
		allrows_rec := dPortedLineSortPhones(acctno = L.acctno and phoneno = L.phoneno and event_date < L.event_date);
		SELF.disconnect_date :=	MAX(L.disconnect_date, MAX(allrows_rec, allrows_rec.disconnect_date)
			,MAX(allrows_rec,allrows_rec.swapped_phone_number_date)); // swaps also produces a disconnected phone
		SELF.ported_date :=	MAX(L.ported_date, MAX(allrows_rec, allrows_rec.ported_date));
		SELF.line_type_last_seen :=	MAX(L.line_type_last_seen, MAX(allrows_rec, allrows_rec.line_type_last_seen));

		//Check if the line/serv type is blank, if it is we use the latest record with a value in that field.
		//Since the dataset is already sorted by -event_date we just have to filter it and take the first entry.
		//In the event that the filtered dataset is empty it will pass forward a blank string.
		SELF.phone_serv_type :=	IF(L.phone_serv_type = '', allrows_rec(phone_serv_type <> '')[1].phone_serv_type, L.phone_serv_type);
		SELF.phone_line_type :=	IF(L.phone_line_type = '', allrows_rec(phone_line_type <> '')[1].phone_line_type, L.phone_line_type);

		SELF.swapped_phone_number_date := MAX(L.swapped_phone_number_date, MAX(allrows_rec, allrows_rec.swapped_phone_number_date));
		SELF.new_phone_number_from_swap	:= MAX(L.new_phone_number_from_swap, MAX(allrows_rec, allrows_rec.new_phone_number_from_swap));
		SELF.suspended_date	:= MAX(L.suspended_date, MAX(allrows_rec, allrows_rec.suspended_date));
		SELF.reactivated_date := MAX(L.reactivated_date, MAX(allrows_rec, allrows_rec.reactivated_date));
		SELF.phone_line_type_desc := IF(SELF.phone_line_type = '', Phones.Constants.PhoneServiceType.Other, Phones.Functions.LineServiceTypeDesc((INTEGER)SELF.phone_line_type))[1];
		SELF.phone_serv_type_desc := IF(SELF.phone_serv_type = '', Phones.Constants.PhoneServiceType.Other, Phones.Functions.LineServiceTypeDesc((INTEGER)SELF.phone_serv_type))[1];
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
		SELF.event_type := MAP( R.source IN Consts.set_VERIFICATION and is_line_match => Consts.VERFICATION,
			R.source IN Consts.set_VERIFICATION and ~is_line_match and C <> 1 => Consts.PORTED_LINE,
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