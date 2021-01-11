IMPORT Phones, STD, UT, dx_PhonesInfo;

EXPORT GetPhoneMetadata_wLERG6(DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dBatchPhonesIn,
  Phones.IParam.BatchParams in_mod) := FUNCTION

  Layout_BatchRaw	:= Phones.Layouts.PhoneAttributes.Raw;

  Layout_PhonesOut := RECORD
      Layout_BatchRaw - acctno;
  END;


  today := STD.Date.Today();
  earliestAllowedDate := (UNSIGNED)ut.date_math((STRING)today, -in_mod.max_age_days);

  //Get phone data from Roxie

  phoneInfo := DEDUP(SORT(PROJECT(dBatchPhonesIn, TRANSFORM(Phones.Layouts.rec_phoneLayout, SELF.phone := LEFT.phoneno)), phone), phone);

  dPortedMetadataPhones := JOIN(phoneInfo, Phones.GetPhoneMetaData.CombineRawPhoneData(phoneInfo),
                          LEFT.phone = RIGHT.phone,
                          TRANSFORM(Layout_PhonesOut,
                          SELF.phone := LEFT.phone,
                          SELF := RIGHT,
                          SELF := []),
                          LIMIT(0), LEFT OUTER, KEEP(Phones.Constants.PhoneAttributes.MaxRecsPerPhone));

  dPhone_wCurrentCarrierInfo := dPortedMetadataPhones(is_ported OR source = Phones.Constants.Sources.Lerg6);

  dPhone_wOldCarrierInfo := DEDUP(SORT(JOIN(dPortedMetadataPhones, dPhone_wCurrentCarrierInfo,
                            LEFT.phone = RIGHT.phone,
                            TRANSFORM(Layout_PhonesOut,
                            SELF := LEFT),
                            LEFT ONLY), phone), phone);		//Should look up Lerg6 index only if that data is not available in ported_metadata index

  Lerg6_lookup := dx_PhonesInfo.RAW.GetLerg6Phones(dPhone_wOldCarrierInfo);

  Layout_PhonesOut transformLerg6(Layout_PhonesOut l, Lerg6_lookup r) := TRANSFORM
    is_block := (r.block_id = Phones.Constants.PhoneAttributes.DEFAULT_BLOCK_ID);
    SELF.phone := l.phone;
    SELF.source := r.source;
    SELF.dt_first_reported := IF(is_block, 0, (Integer)r.dt_first_reported);
    SELF.dt_last_reported := IF(is_block, 0, (Integer)r.dt_last_reported); // Need to keep default at bottom as it is not an exact match
    SELF.account_owner := r.ocn;
    SELF.local_area_transport_area := r.lata;
    SELF.vendor_last_reported_dt := IF(is_block, 0,(Integer)r.dt_last_reported);
    SELF.vendor_first_reported_dt := IF(is_block, 0,(Integer)r.dt_first_reported);
    SELF := [];
  END;



  dLerg6Phones := JOIN(dPhone_wOldCarrierInfo, Lerg6_lookup,
                        (LEFT.phone[1..3] =RIGHT.npa and left.phone[4..6]=RIGHT.nxx AND
                        (left.phone[7]=RIGHT.block_id or RIGHT.block_id = Phones.Constants.PhoneAttributes.DEFAULT_BLOCK_ID) AND
                        RIGHT.is_current = TRUE),
                        transformLerg6(LEFT, RIGHT),LEFT OUTER, LIMIT(0),KEEP(Phones.Constants.PhoneAttributes.MaxRecsPerPhone));

  filteredLerg6Phones := DEDUP(SORT(dLerg6Phones,phone,-dt_last_reported),phone);


  dPortedPhones := dPortedMetadataPhones + filteredLerg6Phones;



  //Add additional carrier info to Lerg6 records. They don't contain this information.
  //However records retrieved from the metadata file should be left alone.
  //is_current looks like it's true for all records but we are keeping the old logic for now.
  Layout_PhonesOut tAppendCarrierRefInfo1(Layout_PhonesOut le, RECORDOF(dx_PhonesInfo.Key_Source_Reference.ocn_name) ri) :=  TRANSFORM

    is_carrier_info := ri.contact_function = '' AND ri.overall_ocn <> '' AND (ri.carrier_city != '' OR ri.carrier_state != '');

    //All records get carrier_city and carrier_state added
    SELF.ocn_abbr_name           := IF(is_carrier_info, ri.ocn_abbr_name, le.ocn_abbr_name);
    SELF.carrier_city            := IF(is_carrier_info, ri.carrier_city, le.carrier_city);
    SELF.carrier_name            := IF(is_carrier_info, ri.carrier_name, le.carrier_name);
    SELF.carrier_category        := IF(is_carrier_info, ri.category, le.carrier_category);
    SELF.carrier_state           := IF(is_carrier_info, ri.carrier_state, le.carrier_state);
    SELF.carrier_route           := IF(is_carrier_info, ri.cart, le.carrier_route);
    SELF.carrier_route_zonecode  := IF(is_carrier_info, ri.cr_sort_sz, le.carrier_route_zonecode);
    SELF.delivery_point_code     := IF(is_carrier_info, ri.dpbc, le.delivery_point_code);
    SELF.affiliated_to           := IF(is_carrier_info, ri.affiliated_to, le.affiliated_to);
    SELF.contact_name            := IF(is_carrier_info, ri.contact_name, le.contact_name);
    SELF.contact_address1        := IF(is_carrier_info, ri.carrier_address1, le.contact_address1);
    SELF.contact_address2        := IF(is_carrier_info, ri.carrier_address2, le.contact_address2);
    SELF.contact_city            := IF(is_carrier_info, ri.carrier_city, le.carrier_city);
    SELF.contact_state           := IF(is_carrier_info, ri.carrier_state, le.carrier_state);
    SELF.contact_zip             := IF(is_carrier_info, ri.carrier_zip, le.contact_zip);
    SELF.contact_phone           := IF(is_carrier_info, ri.carrier_phone, le.contact_phone);
    SELF.contact_fax             := IF(is_carrier_info, ri.contact_fax, le.contact_fax);
    SELF.contact_email           := IF(is_carrier_info, ri.contact_email, le.contact_email);

  //Add the remaining information
  SELF.line:=IF(le.line = '', ri.line, le.line);
  SELF.serv:=IF(le.serv = '', ri.serv, le.serv);
  SELF.spid:=IF(le.spid = '', ri.spid, le.spid);
  SELF.operator_fullname:=IF(le.operator_fullname = '', ri.operator_full_name, le.operator_fullname);
  SELF.prepaid:= ri.prepaid;
  SELF := le;

  END;

  //denormalize to join index records for contact function = '' and overall ocn <> '' -  limit to 100
  dPortedPhonesFinal := DENORMALIZE(dPortedPhones, dx_PhonesInfo.Key_Source_Reference.ocn_name,
                  KEYED(LEFT.account_owner = RIGHT.ocn) AND
                  RIGHT.is_current,
                  tAppendCarrierRefInfo1(LEFT, RIGHT),
                  LEFT OUTER, LIMIT(100, SKIP));
  //prioritize PORTED
  dPortedPhonesSorted := SORT(dPortedPhonesFinal, phone, -vendor_last_reported_dt,
                vendor_first_reported_dt, -dt_last_reported, dt_first_reported, source NOT IN Phones.Constants.Sources.set_ICONECTIV_SRC,
                record);


  Layout_BatchRaw ProcessRecs(Phones.Layouts.PhoneAttributes.BatchIn L, Layout_PhonesOut R) := TRANSFORM
    SELF.acctno := L.acctno;
    SELF.phoneno := R.phone;
    SELF.is_current	:= FALSE;

    // * Disconnect event_date = deact_start_dt
    // * Ported phone event_date = port_start_dt
    // * Swap Phone Number event_date = swap_start_dt
    // * Suspended Number event_date = deact_start_dt
    // * Reactivated Number event_date = react_start_dt
    boolean ported_phone := R.source IN Phones.Constants.Sources.set_ICONECTIV_SRC;


    //identifies both historic and current disconnect records
    //is_deact can also be P - Ported - we want to ignore P records because they don't represent true disconnects.
    boolean disconnected := R.deact_code = Phones.Constants.TransactionCodes.DISCONNECTED_CODE and (R.is_deact = 'Y' OR R.is_deact = 'N');
    boolean number_swapped := R.phone_swap <> '';
    boolean suspended := R.deact_code = Phones.Constants.TransactionCodes.SUSPENDED_CODE and in_mod.include_temp_susp_reactivate;
    boolean reactivated := R.is_react = 'Y'; //remove L.deact_code=Consts.SUSPENDED_CODE to include PX(suspension reacts) and PG(Gong additions)
    boolean VERFICATION := R.source IN Phones.Constants.Sources.SET_VERIFICATION;
    boolean isActiveVerification := R.transaction_code = Phones.Constants.TransactionCodes.ACTIVE_STATUS;
    event_type := if(ported_phone, Phones.Constants.PhoneAttributes.PORTED_PHONE, '') +
            if(disconnected and not ported_phone, Phones.Constants.PhoneAttributes.DISCONNECTED, '') +
            if(reactivated, Phones.Constants.TransactionCodes.REACTIVATED, '') +
            if(number_swapped, Phones.Constants.PhoneAttributes.NUMBER_SWAPPED, '') +
            if(suspended, Phones.Constants.PhoneAttributes.SUSPENDED, '') +
            if(VERFICATION, Phones.Constants.PhoneAttributes.VERFICATION, '') +
            if(isActiveVerification, Phones.Constants.PhoneAttributes.ACTIVE_VERIFICATION, ''); // is an 'AS' record with passed OTP

    event_date := Map(VERFICATION => R.vendor_last_reported_dt,
                      isActiveVerification => R.dt_first_reported,
                      MAX(R.port_start_dt, R.swap_start_dt, R.deact_start_dt, R.react_start_dt));
    SELF.event_type := event_type;
    SELF.event_date	:= if(event_type <> '', event_date, 0);

    // populate disconnect date based on record's event type to report most recent event date
    SELF.disconnect_date := MAP(disconnected => R.deact_start_dt,
                  number_swapped => R.swap_start_dt,
                  0);

    SELF.ported_date := if(ported_phone, R.port_start_dt, 0);
    SELF.carrier_id	:= R.account_owner;
    SELF.carrier_name := R.carrier_name;
    SELF.carrier_category := R.carrier_category;
    SELF.operator_id := R.spid;
    SELF.operator_name := if(R.operator_fullname <> '', R.operator_fullname, R.carrier_name);
    SELF.line_type_last_seen := CASE(R.source,
                    Phones.Constants.Sources.ATT_LIDB_SRC => R.vendor_last_reported_dt,
                    Phones.Constants.Sources.LERG6 => R.vendor_last_reported_dt,
                    Phones.Constants.Sources.ICONECTIV_SRC => R.port_start_dt, //probably should include port_end_dt
                    Phones.Constants.Sources.ICONNECTIVE_PORT_VALIDATE_SRC => R.port_start_dt,
                    Phones.Constants.Sources.GONG_DISCONNECT_SRC => MAX(R.deact_start_dt,R.deact_end_dt,R.react_start_dt,R.react_end_dt),
                    0);
    SELF.phone_serv_type := if(ported_phone or VERFICATION, R.serv, ''); // PG are not always shown as landlines even though they came from gong ???
    SELF.phone_line_type := if(ported_phone or VERFICATION, R.line, '');
    SELF.swapped_phone_number_date := if(number_swapped, R.swap_start_dt, 0);
    SELF.new_phone_number_from_swap	:= R.phone_swap;
    SELF.suspended_date := if(suspended, R.deact_start_dt, 0);
    SELF.reactivated_date := if(reactivated, R.react_start_dt, 0);
    SELF.source := R.source;
    SELF.prepaid := R.prepaid;
    SELF.error_desc	:= R.error_desc;
    SELF.carrier_city := R.carrier_city;
    SELF.carrier_state := R.carrier_state;

    //Check if the current record is outdated, from L6, if so we mark dialable false.
    boolean is_outdated := SELF.event_date < earliestAllowedDate;
    SELF.dialable := ~is_outdated AND R.source <> Phones.Constants.Sources.DISCONNECT_SRC;

    //These values are assigned below when all the most recent data is combined so they match what is being displayed.
    SELF.phone_line_type_desc := '';
    SELF.phone_serv_type_desc := '';
    SELF := R;
  END;

  dPhones_w_Metadata := JOIN(dBatchPhonesIn, dPortedPhonesSorted,
                            LEFT.phoneno = RIGHT.phone,
                            ProcessRecs(LEFT, RIGHT),
                            LEFT OUTER);

// this temporary layout is used to populate carrier fields for OTP records and phone_status field for all phone records
  Layout_carrier_w_phone_status := RECORD
        string10 phone;
        string32 phone_status;
        string6 account_owner;
        string25 ocn_abbr_name;
        string60 operator_fullname;
        string operator_id;
        string operator_name;
        string carrier_id;
        string30 carrier_city;
        string60 carrier_name;
        string10 carrier_category;
        string2 carrier_state;
        string4 carrier_route;
        string1 carrier_route_zonecode;
        string2 delivery_point_code;
        string80 affiliated_to;
        string60 contact_name;
        string30 contact_address1;
        string30 contact_address2;
        string30 contact_city;
        string2 contact_state;
        string9 contact_zip;
        string10 contact_phone;
        string10 contact_fax;
        string60 contact_email;
        string1 line;
        string1 serv;
        string10 spid;
        string2 prepaid;
        unsigned8 line_type_last_seen;
        string1 phone_serv_type;
        string1 phone_line_type;
      END;

  Layout_carrier_w_phone_status ProcessStatus(Layout_BatchRaw L, DATASET(Layout_BatchRaw) allrows) :=  TRANSFORM
     today :=  STD.Date.Today();
     max_deact_start_dt := MAX(allrows, deact_start_dt);
     max_port_start_dt	:= MAX(allrows, porting_dt);
     max_react_start_dt	:= MAX(allrows, react_start_dt);
     max_swap_start_dt := MAX(allrows, swap_start_dt);
     max_event_dt := MAX(allrows, event_date);

     daysbetween_deact_port := STD.Date.DaysBetween(max_port_start_dt, max_deact_start_dt);
     daysbetween_deact_today  := STD.Date.DaysBetween(max_deact_start_dt , today);
     daysbetween_swap_today := STD.Date.DaysBetween(max_swap_start_dt, today);
     yearsbetween_deact_today := STD.Date.YearsBetween(max_deact_start_dt, today);

     // check if there are multiple most recent phone records
     recent_records := allrows(event_date = max_event_dt);
     // Set of transaction codes for most recent records for a given phone
     set_recent_tr_code := SET(recent_records,transaction_code);
     // phone has most recent 'AS' record
     hasRecentASRecord := Phones.Constants.TransactionCodes.ACTIVE_STATUS	IN set_recent_tr_code;

     /*  check whether phone has other most recent records which are not 'AS' - we are checking for other records in order to decide
      whether the phone status will be active(all most recent records are of type AS) or we can set it to presumed active in case
      there are records of other types along with the 'AS' record */
     is_active_record := IF(hasRecentASRecord,
                            COUNT(recent_records(transaction_code = Phones.Constants.TransactionCodes.ACTIVE_STATUS)) = COUNT(recent_records),
                            FALSE);

     Is_recent_swap := (max_swap_start_dt <= max_port_start_dt OR max_swap_start_dt <= max_react_start_dt);

     Isport_react_event := (max_port_start_dt != 0 OR max_react_start_dt !=0);

     IsDeactInactiveStatus := (Isport_react_event
                            AND daysbetween_deact_port > Phones.Constants.PhoneStatus.LastActivityThreshold);
     IsSwapInactiveStatus := (Isport_react_event
                            AND daysbetween_deact_port < Phones.Constants.PhoneStatus.LastActivityThreshold
                            AND ~Is_recent_swap);

     IsportInactiveStatus := Isport_react_event AND max_port_start_dt = 0 AND
                (max_deact_start_dt > max_react_start_dt OR max_swap_start_dt > max_react_start_dt);

     Boolean Is_recent_deactswap(Integer Threshold_val) := daysbetween_deact_today <= Threshold_val  OR daysbetween_swap_today <= Threshold_val;
     SELF.phone_status := MAP(	hasRecentASRecord AND is_active_record => Phones.Constants.PhoneStatus.Active,
                                Isport_react_event AND max_port_start_dt = 0 AND
                                (max_deact_start_dt <= max_react_start_dt OR max_swap_start_dt <= max_react_start_dt) => Phones.Constants.PhoneStatus.Active,
                                max_port_start_dt != 0 AND ~IsDeactInactiveStatus AND Is_recent_swap => Phones.Constants.PhoneStatus.Active,
                                
                                (IsDeactInactiveStatus OR max_deact_start_dt != 0) AND yearsbetween_deact_today >= Phones.Constants.PhoneStatus.DeactInactiveThresholdYears => Phones.Constants.PhoneStatus.Inactive,
                                hasRecentASRecord AND ~is_active_record => Phones.Constants.PhoneStatus.PresumedActive,
                                IsportInactiveStatus AND ~Is_recent_deactswap(Phones.Constants.PhoneStatus.ActLowerTh) AND
                                (daysbetween_deact_today >= Phones.Constants.PhoneStatus.ActUpperTh AND daysbetween_swap_today >= Phones.Constants.PhoneStatus.ActUpperTh) => Phones.Constants.PhoneStatus.PresumedActive,
                                max_port_start_dt != 0 AND IsDeactInactiveStatus AND daysbetween_deact_today >= Phones.Constants.PhoneStatus.ActUpperTh => Phones.Constants.PhoneStatus.PresumedActive,
                                IsSwapInactiveStatus AND daysbetween_swap_today >= Phones.Constants.PhoneStatus.ActUpperTh => Phones.Constants.PhoneStatus.PresumedActive,
                                ~Isport_react_event AND (max_deact_start_dt != 0 OR max_swap_start_dt !=0) AND
                                (daysbetween_deact_today >= Phones.Constants.PhoneStatus.ActUpperTh AND daysbetween_swap_today >= Phones.Constants.PhoneStatus.ActUpperTh)   => Phones.Constants.PhoneStatus.PresumedActive,
                                ~Isport_react_event AND  (max_deact_start_dt = 0 AND max_swap_start_dt =0) AND (L.line != Phones.Constants.PhoneServiceType.line_landline AND L.line != '')  => Phones.Constants.PhoneStatus.PresumedActive,

                                IsportInactiveStatus AND Is_recent_deactswap(Phones.Constants.PhoneStatus.ActLowerTh) => Phones.Constants.PhoneStatus.Inactive,
                                IsDeactInactiveStatus AND daysbetween_deact_today < Phones.Constants.PhoneStatus.ActLowerTh => Phones.Constants.PhoneStatus.Inactive,
                                IsSwapInactiveStatus AND daysbetween_swap_today < Phones.Constants.PhoneStatus.ActLowerTh => Phones.Constants.PhoneStatus.Inactive,
                                ~Isport_react_event AND (max_deact_start_dt != 0 OR max_swap_start_dt !=0)
                                 AND Is_recent_deactswap(Phones.Constants.PhoneStatus.ActLowerTh)  =>  Phones.Constants.PhoneStatus.Inactive,

                                IsportInactiveStatus AND ~Is_recent_deactswap(Phones.Constants.PhoneStatus.ActLowerTh) AND
                                (daysbetween_deact_today < Phones.Constants.PhoneStatus.ActUpperTh OR daysbetween_swap_today < Phones.Constants.PhoneStatus.ActUpperTh) => Phones.Constants.PhoneStatus.NotAvailable,
                                IsDeactInactiveStatus  AND daysbetween_deact_today < Phones.Constants.PhoneStatus.ActUpperTh => Phones.Constants.PhoneStatus.NotAvailable,
                                IsSwapInactiveStatus AND daysbetween_swap_today < Phones.Constants.PhoneStatus.ActUpperTh => Phones.Constants.PhoneStatus.NotAvailable,
                                (max_deact_start_dt != 0 OR max_swap_start_dt !=0) AND ~Is_recent_deactswap(Phones.Constants.PhoneStatus.ActLowerTh) AND
                                (daysbetween_deact_today < Phones.Constants.PhoneStatus.ActUpperTh OR daysbetween_swap_today < Phones.Constants.PhoneStatus.ActUpperTh) => Phones.Constants.PhoneStatus.NotAvailable,
                                (L.line = Phones.Constants.PhoneServiceType.line_landline) => Phones.Constants.PhoneStatus.NotAvailable,

                                Phones.Constants.PhoneStatus.NotAvailable);

      // find the most recent Port/PB/L6 record to fill the carrier information for OT records
      portRecords := SORT(allRows(source IN Phones.Constants.Sources.set_VERIFICATION OR source IN Phones.Constants.Sources.set_ICONECTIV_SRC),-event_date);
      SELF.phone := L.phone;
      //Carrier information from this rollup (from most recent port for a phone) is used to populate carrier information for OTP
      //in the final join

      SELF:= IF(hasRecentASRecord,ROW(portRecords[1],Layout_carrier_w_phone_status),ROW([],Layout_carrier_w_phone_status));
  END;

  dPhoneStaus_grp := GROUP(SORT(dPhones_w_Metadata, phone,-event_date),phone);

  dphone_status_roll := ROLLUP(dPhoneStaus_grp, GROUP, ProcessStatus(LEFT, ROWS(LEFT)));


  Layout_BatchRaw appendStatus_OTPcarrier(Layout_BatchRaw L, Layout_carrier_w_phone_status R) := TRANSFORM
    // check if the record is a recent OTP record
    is_recent_OTP := L.source = phones.Constants.sources.PHONEFRAUD_OTP and  R.operator_id <> '';
    // populate phone status information for all records
    SELF.phone_status :=  R.phone_status;
    //Iconnective restrictions
    SELF.port_start_dt := IF(in_mod.AllowPortingData, L.port_start_dt, 0);
    SELF.port_start_time := IF(in_mod.AllowPortingData, L.port_start_time, '');
    SELF.port_end_dt := IF(in_mod.AllowPortingData, L.port_end_dt, 0);
    SELF.port_end_time := IF(in_mod.AllowPortingData, L.port_end_time, '');
    SELF.porting_dt := IF(in_mod.AllowPortingData, L.porting_dt, 0);
    SELF.porting_time := IF(in_mod.AllowPortingData, L.porting_time, '');
    SELF.ported_date := IF(in_mod.AllowPortingData, L.ported_date, 0);
    SELF.remove_port_dt := IF(in_mod.AllowPortingData, L.remove_port_dt, 0);
    SELF.spid := MAP(in_mod.AllowPortingData AND is_recent_OTP => R.spid,
                     in_mod.AllowPortingData => L.spid,
                     '');
    SELF.operator_id := MAP(in_mod.AllowPortingData AND is_recent_OTP => R.operator_id,
                     in_mod.AllowPortingData => L.operator_id,
                     '');
    // populate carrier fields for OTP records from previous rollup
    SELF := if(is_recent_OTP,R,ROW(L,Layout_carrier_w_phone_status));
    SELF := L;
  END;

  dPhonesMetadata_w_status := JOIN(dPhones_w_Metadata, dphone_status_roll,
                                        LEFT.phone = RIGHT.phone,
                                        appendStatus_OTPcarrier(LEFT,RIGHT),
                                        LEFT OUTER, LIMIT(0), KEEP(1));

  #IF(Phones.Constants.Debug.PhoneMetadata_wLIDB)
        OUTPUT(dBatchPhonesIn,NAMED('dBatchPhonesIn'), EXTEND);
        OUTPUT(dPortedMetadataPhones,NAMED('dPortedMetadataPhones'), EXTEND);
        // OUTPUT(numbersForDelta,NAMED('numbersForDelta'), EXTEND);
        // OUTPUT(deltaATTPhones,NAMED('deltaATTPhones'), EXTEND);
        // OUTPUT(filteredDeltaATTPhones,NAMED('filteredDeltaATTPhones'), EXTEND);
        // OUTPUT(dPortedDeltaPhones,NAMED('dPortedDeltaPhones'), EXTEND);
        // OUTPUT(dPortedMetadataDeltaPhones,NAMED('dPortedMetadataDeltaPhones'), EXTEND);
        // OUTPUT(latestPhoneRecs,NAMED('latestPhoneRecs'), EXTEND);
        // OUTPUT(oldOrIncompleteRecs,NAMED('oldOrIncompleteRecs'), EXTEND);
        // OUTPUT(numbersWithNoData,NAMED('numbersWithNoData'), EXTEND);
         // OUTPUT(numbersForRealtime,NAMED('numbersForRealtime'), EXTEND);
                // OUTPUT(realtimeATTPhones,NAMED('realtimeATTPhones'), EXTEND);
                // OUTPUT(filteredAttPhones,NAMED('filteredAttPhones'), EXTEND);
                // OUTPUT(dPortedRealtime,NAMED('dPortedRealtime'), EXTEND);
                OUTPUT(dPortedPhones,NAMED('dPortedPhones'), EXTEND);
                OUTPUT(dPortedPhonesFinal,NAMED('dPortedPhonesFinal'), EXTEND);
                OUTPUT(dPortedPhonesSorted,NAMED('dPortedPhonesSorted'), EXTEND);
                OUTPUT(filteredLerg6Phones,NAMED('filteredLerg6Phones'), EXTEND);
  #END
RETURN dPhonesMetadata_w_status;
END;
