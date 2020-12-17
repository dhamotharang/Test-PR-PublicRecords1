IMPORT Phones, STD, UT;

EXPORT PhoneAttributes_BatchRecords(
    DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dBatchPhonesIn,
    Phones.IParam.BatchParams in_mod)
    := FUNCTION

    Layout_BatchOut := Phones.Layouts.PhoneAttributes.BatchOut;
    Layout_BatchRaw    := Phones.Layouts.PhoneAttributes.Raw;
    
     dIntermediatePhonemetadata := Phones.GetPhoneMetadata_wLERG6(dBatchPhonesIn,in_mod);

    dWDNCPhones := $.GetWDNC(dBatchPhonesIn, in_mod);

    dIntermediateBatchPhones := SORT(dIntermediatePhonemetadata + dWDNCPhones, phone,-event_date);
    
  dFilterBatchPhones    := if(in_mod.include_temp_susp_reactivate,
  dIntermediateBatchPhones,
  dIntermediateBatchPhones(event_type NOT IN 
          [Phones.Constants.PhoneAttributes.SUSPENDED, Phones.Constants.TransactionCodes.REACTIVATED, Phones.Constants.TransactionCodes.REACTIVATED+Phones.Constants.PhoneAttributes.SUSPENDED]));

    //Check previous records to mark PORTED_LINE events
    //A PORTED_PHONE event becomes a PORTED_PHONE+PORTED_LINE event when the most recent historic record
    //has either serv or line populated with a value different from the current record OR
    //if no historic record exists with line or serv
    
    dPortedLineSortPhones := SORT(dFilterBatchPhones, acctno, phoneno, -event_date);

    Layout_BatchOut tMostRecentRecord(Layout_BatchRaw L) := TRANSFORM
        allrows_rec := dPortedLineSortPhones(acctno = L.acctno and phoneno = L.phoneno and event_date <= L.event_date);
		SELF.disconnect_date :=	MAX(MAX(allrows_rec(is_deact IN ['Y', 'N']),allrows_rec.disconnect_date), MAX(allrows_rec,allrows_rec.swapped_phone_number_date)); // swaps also produces a disconnected phone
	
    //    SELF.ported_date :=    MAX(L.ported_date, MAX(allrows_rec, allrows_rec.ported_date));
        SELF.line_type_last_seen :=    MAX(L.line_type_last_seen, MAX(allrows_rec, allrows_rec.line_type_last_seen));

        //Check if the line/serv type is blank, if it is we use the latest record with a value in that field.
        //Since the dataset is already sorted by -event_date we just have to filter it and take the first entry.
        //In the event that the filtered dataset is empty it will pass forward a blank string.
        SELF.phone_serv_type :=    IF(L.phone_serv_type = '', sort(allrows_rec(phone_serv_type <> ''), -line_type_last_seen, source <> Phones.Constants.Sources.PHONES_WDNC)[1].phone_line_type,L.phone_serv_type);
        SELF.phone_line_type :=    IF(L.phone_line_type = '', sort(allrows_rec(phone_line_type <> ''), -line_type_last_seen, source <> Phones.Constants.Sources.PHONES_WDNC)[1].phone_line_type,L.phone_line_type);

        SELF.swapped_phone_number_date := MAX(L.swapped_phone_number_date, MAX(allrows_rec, allrows_rec.swapped_phone_number_date));
        SELF.new_phone_number_from_swap    := MAX(L.new_phone_number_from_swap, MAX(allrows_rec, allrows_rec.new_phone_number_from_swap));
        SELF.suspended_date    := MAX(L.suspended_date, MAX(allrows_rec, allrows_rec.suspended_date));
        SELF.reactivated_date := MAX(L.reactivated_date, MAX(allrows_rec, allrows_rec.reactivated_date));
        SELF.phone_line_type_desc := IF(SELF.phone_line_type = '', Phones.Constants.PhoneServiceType.Other, Phones.Functions.LineServiceTypeDesc((INTEGER)SELF.phone_line_type))[1];
        SELF.phone_serv_type_desc := IF(SELF.phone_serv_type = '', Phones.Constants.PhoneServiceType.Other, Phones.Functions.LineServiceTypeDesc((INTEGER)SELF.phone_serv_type))[1];
        SELF.phone_status := allrows_rec(phone_status<>'')[1].phone_status;
        SELF.ported_date := 0;//Iconnective change
        SELF.carrier_id := '';
        SELF.operator_id := '';
        SELF.event_type := '';
        SELF :=     L;
    END;

    dPhonesMostRecentRecord := PROJECT(dPortedLineSortPhones,tMostRecentRecord(LEFT));

    //Now let's mark the most current record as such
    Layout_BatchOut tMarkCurrentRecords(Layout_BatchOut L, Layout_BatchOut R) := TRANSFORM
        boolean is_same_account := L.acctno = R.acctno and L.phoneno = R.phoneno;
        SELF.is_current                 := ~is_same_account;
        SELF.phone_status               := IF(is_same_account, '', R.phone_status);//Keeping only for current record
        SELF                                        := R;
    END;
    dPhonesWithCurrent := ITERATE(dPhonesMostRecentRecord, tMarkCurrentRecords(LEFT, RIGHT))(is_current or event_date <> 0);

    //Some rare cases where we have the same phoneno and event_date, but event_type is C in one and CL in the other
    //I doubt we would have any other event_type cases with the same phoneno and event_date
    Layout_BatchOut tRollRecords(Layout_BatchOut L, Layout_BatchOut R) := TRANSFORM
        //SELF.event_type := STD.STR.combineWords(set(
        //    dedup(sort(ut.WordTokenizer(L.event_type+R.event_type)(char<>''),char),char),char), '');
        isWDNC := (R.source = Phones.Constants.Sources.PHONES_WDNC);
        SELF.phone_line_type := IF(isWDNC, R.phone_line_type, L.phone_line_type);
        SELF.phone_serv_type := IF(isWDNC, R.phone_serv_type, L.phone_serv_type);
        SELF.line_type_last_seen := IF(isWDNC, R.line_type_last_seen, L.line_type_last_seen);
        SELF.phone_line_type_desc := IF(isWDNC, R.phone_line_type_desc, L.phone_line_type_desc);
        SELF.phone_serv_type_desc := IF(isWDNC, R.phone_serv_type_desc, L.phone_serv_type_desc);
        SELF := L;
    END;

    dRolledUpPhones := ROLLUP(SORT(dPhonesWithCurrent, acctno, phoneno, -event_date, source = Phones.Constants.Sources.PHONES_WDNC),
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
        output(dWDNCPhones,named('dWDNCPhones'));
    #END
  RETURN dBatchPhonesOut;
END;
